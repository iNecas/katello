require 'stomp'

STOMP_SERVER = "stomp://kat46.inecas.cz:61613"

module Katello
  module Bus
    def self.persisted
      @persisted ||= Dynflow::Bus::ActiveRecordBus.new
    end

    def self.messaged
      @messaged ||= MessagedBus.new
    end

    class MessagingImpl

      def client
        Stomp::Client.new(STOMP_SERVER)
      end
    end

    Messaging = MessagingImpl.new

    class MessagedBus < Dynflow::Bus

      def initialize
        super
        @client = Messaging.client
      end

      def execute(execution_plan)
        # this allows the execution phase to happen in the background runner
        @client.publish('/queue/plans', execution_plan.persistence.persistence_id.to_s)
      end

      # waits for new plans to be executed
      def subscribe_executor
        Messaging.client.subscribe('/queue/plans') do |message|
          puts 'executing new plan'
          plan_id = message.body
          plan = self.persisted_plan(plan_id)
          execute_delayed(plan)
        end

        puts 'Waiting for events'
        loop { sleep 1 }

      end

      # waits for steps to be processed
      def subscribe_runner
        Messaging.client.subscribe('/queue/steps/run') do |message|
          puts 'running a step'
          step_data = JSON.parse(message.body)
          puts step_data.inspect
          self.execution_driver.run_step_delayed(step_data)
        end
        puts 'Waiting for steps to handle'
        loop { sleep 1 }
      end

      def execute_delayed(execution_plan)
        run_execution_plan(execution_plan)
        in_transaction_if_possible do
          unless self.finalize(execution_plan)
            rollback_transaction
          end
        end
        execution_plan.persist(true)
      end

      def transaction_driver
        Katello::Bus.persisted.transaction_driver
      end

      def persistence_driver
        Katello::Bus.persisted.persistence_driver
      end

      def execution_driver
        @execution_driver ||= MessagedExecutor.new
      end

    end

    class MessagedExecutor < Dynflow::Executor

      # overriding the default behaviour to handle the step through
      # message queue
      def run_step(step)
        puts __method__
        step.replace_references!
        return true if %w[skipped success].include?(step.status)
        step.persist_before_run
        send_step(step, step.persistence.persistence_id, '/queue/steps/run')
        return step
      end

      # processing a step in runner
      def run_step_delayed(step_data)
        puts __method__
        step = Dynflow::Step.decode(step_data)
        success = step.catch_errors do
          step.output = {}
          step.action.run
        end
        send_step(step, step_data['step_id'], '/queue/steps/finish')
      end

      def run_sync(step)
        # not used for simple exec plan, but when having dependent
        # steps
        run(step)
        wait_for(step)
      end

      def wait_for(*steps)
        ids_to_steps = steps.reduce({}) do |hash, step|
          hash.update(step.persistence.persistence_id.to_s => step)
        end
        selector = "step_id in (#{ids_to_steps.keys.map { |id| "'#{id}'" }.join(', ')})"
        waiting_client = Messaging.client
        finished_steps = 0
        waiting_client.subscribe('/queue/steps/finish',
                                 :selector => selector) do |message|
          begin
          step_id = message.headers['step_id']
            puts "finishing step #{step_id}"
            step_data = JSON.parse(message.body)
            updated_step = Dynflow::Step.decode(step_data)

            step = ids_to_steps[step_id]
            step.output.merge!(updated_step.output)
            step.error = updated_step.error
            step.status = updated_step.status

            step.persist_after_run
            finished_steps += 1
          rescue => e
            puts e.message
            puts e.backtrace.join("\n")
          end
        end

        loop do
          # waiting for all responses
          break if finished_steps == steps.count
          sleep 0.3
        end

        ret = steps.map { |s| s.status == 'success' }
        waiting_client.close
        return ret
      rescue => e
        puts e.message
        puts e.backtrace.join("\n")
        return steps.map { |x| true }
      end

      # helper method to send step on a queue (both request and response)
      def send_step(step, step_id, queue)
        step_data = step.encode
        step_data['step_id'] = step_id
        puts "publishing on #{queue} message:"
        puts step_data.to_json
        Messaging.client.publish(queue, step_data.to_json, 'step_id' => step_id)
      end

    end

  end
end
