module Actions
  module Headpin
    module Candlepin

      class EnvironmentCreate < Dynflow::Action

        input_format do
          param :organization_label
          param :cp_id
          param :name
          param :description
        end

        def run
          Resources::Candlepin::Environment.create(input['organization_label'],
                                                   input['cp_id'],
                                                   input['name'],
                                                   input['description'])
        end

      end

    end
  end
end
