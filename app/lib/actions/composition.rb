module Actions

  module Composition
    def sub_plan(action_class, *args)
      plan_sub_plan(action_class, args, false)
    end

    def async_sub_plan(action_class, *args)
      plan_sub_plan(action_class, args, true)
    end

    def create_sub_plan(action_class, *args)
      world.plan(action_class, *args).tap do |execution_plan|
        raise execution_plan.errors.first if execution_plan.error?
      end
    end

    def plan_sub_plan(action_class, args, async = false)
      sub_plan = create_sub_plan(action_class, *args)
      plan_action(Actions::ExecutePlan, sub_plan_id: sub_plan.id, async: async)
    end
  end
end
