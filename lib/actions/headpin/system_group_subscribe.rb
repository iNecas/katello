module Actions
  module Headpin

    class SystemGroupSubscribe < Dynflow::Action

      def plan(group, pools)
        group.systems.each do |system|
          pools.each do |pool|
            plan_action Candlepin::ConsumerSubscribe, system, pool
          end
        end
      end

    end
  end
end
