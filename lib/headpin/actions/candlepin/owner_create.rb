module Headpin
  module Actions
    module Candlepin

      class OwnerCreate < Dynflow::Action

        input_format do
          param :label
          param :name
        end

        def run
          Resources::Candlepin::Owner.create(input['label'], input['name'])
        end

      end

    end
  end
end
