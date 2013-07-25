module Actions
  module Headpin
    module Candlepin

      class EnvironmentUpdate < Dynflow::Action

        include Helpers::CandlepinAction

        input_format do
          param :cp_user
          param :cp_id
          param :content_ids, Array
        end

        def run
          as_cp_user do

            all_env_ids = input['content_ids']
            saved_cp_ids = Resources::Candlepin::Environment.find(input['cp_id'])[:environmentContent].map do |content|
              content[:contentId]
            end

            add_ids = all_env_ids - saved_cp_ids
            unless add_ids.empty?
              Resources::Candlepin::Environment.add_content(input['cp_id'], add_ids)
            end

            delete_ids = saved_cp_ids - all_env_ids.to_a
            unless delete_ids.empty?
              Resources::Candlepin::Environment.delete_content(input['cp_id'], delete_ids)
            end

          end
        end

      end

    end
  end
end
