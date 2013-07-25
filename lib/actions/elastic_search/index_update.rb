module Actions
  module ElasticSearch

    class IndexUpdate < Dynflow::Action

      include Helpers::PulpAction
      include Helpers::CandlepinAction

      def plan(record)
        plan_self('id' => record.id,
                  'class_name' => record.class.name,
                  'pulp_user' => User.current.pulp_user,
                  'cp_user' => User.current.cp_user)
      end

      input_format do
        param :id
        param :class_name
        param :pulp_user
        param :cp_user
      end

      def finalize(*args)
        as_pulp_user do
          as_cp_user do
            model_class = input['class_name'].constantize
            record = model_class.find(input['id'])
            record.update_index
          end
        end
      end

    end
  end
end
