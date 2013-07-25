module Actions
  module Headpin
    module Candlepin

      class EnvironmentCreate < Dynflow::Action

        include Helpers::CandlepinAction

        input_format do
          param :cp_user
          param :organization_label
          param :cp_id
          param :name
          param :description
        end

        def run
          as_cp_user do
            Resources::Candlepin::Environment.create(input['organization_label'],
                                                     input['cp_id'],
                                                     input['name'],
                                                     input['description'])
          end
        end
      end

    end
  end
end
