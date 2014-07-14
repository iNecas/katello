module Actions
  module Candlepin
    class ListenOnEvents < Actions::Base

      Event = Algebrick.type do
        fields! message: String
      end

      Close = Algebrick.atom

      def plan
        # Make sure we don't have two concurrent listening services competing
        if already_running?
          raise "Action #{self.class.name} is already active"
        end
        plan_self
      end

      def run(event = nil)
        match(event,
              (on nil do
                 # initialize the listening service
                 initialize_service
               end),
              (on Event do
                 # react on the event, probably calling ForemanTasks.async_task
                 record_message(event)
               end),
              (on Close | Dynflow::Action::Cancellable::Cancel do
                 # we finished with the listening serivce
                 close_service
               end),
              (on Dynflow::Action::Skip do
                 # do nothing, just skip
               end))
      rescue => e
        action_logger.error(e.message)
      end

      private

      def already_running?
        ForemanTasks::Task::DynflowTask.for_action(self.class).
            where("state NOT IN ('stopped', 'paused')").
            where('external_id != ?', execution_plan_id).any?
      end

      def initialize_service
        output[:messages] = 0
        output[:last_message] = nil
        suspend do |suspended_action|
          ListeningService.initialize(suspended_action)
          at_exit do
            # make sure we close the service at exit to finish the listening action
            suspended_action << Close
          end
        end
      end

      def record_message(event)
        output[:messages] += 1
        output[:last_message] = event.message
        puts("============================ #{event.message}")
        output
        suspend
      end

      def close_service
        ListeningService.instance.close
      end

      class ListeningService
        class << self
          attr_reader :instance
          def initialize(action)
            @instance = self.new(action)
          end

          def close
            @instance.close
            @instance = nil
          end
        end

        def initialize(action)
          @counter = 0
          @thread = Thread.new do
            while true
              @counter += 1
              action << Event["Message no. #{@counter}"]
              sleep 1
            end
          end
        end

        def close
          @thread.kill
        end
      end

    end
  end
end
