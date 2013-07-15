module Actions
  module ElasticSearch

    class IndexUpdate < Dynflow::Action

      def plan(record)
        plan_self('id' => record.id,
                  'class_name' => record.class.name)
      end

      input_format do
        param :id
        param :class_name
      end

      def finalize(*args)
        model_class = input['class_name'].constantize
        record = model_class.find(input['id'])
        record.update_index
      end

    end
  end
end
