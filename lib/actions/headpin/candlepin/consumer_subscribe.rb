module Actions
  module Headpin
    module Candlepin

      class ConsumerSubscribe < Dynflow::Action

        include Helpers::CandlepinAction

        def plan(system, pool)
          plan_self(cp_user: User.current.cp_user,
                    consumer_uuid: system.uuid,
                    pool: pool)
        end

        input_format do
          param :cp_user
          param :consumer_uuid
          param :pool
          param :quantity
        end

        def run
          as_cp_user do
            Resources::Candlepin::Consumer.consume_entitlement(input[:consumer_uuid],
                                                               input[:pool],
                                                               input[:quantity])
          end
        end
      end
    end
  end
end
