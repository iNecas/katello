module Actions
  module Headpin
    module Candlepin

      class OwnerCreate < Dynflow::Action

        include Helpers::CandlepinAction

        input_format do
          param :cp_user
          param :label
          param :name
        end

        def run
          as_cp_user do
            Resources::Candlepin::Owner.create(input['label'], input['name'])
          end
        end

      end

    end
  end
end
