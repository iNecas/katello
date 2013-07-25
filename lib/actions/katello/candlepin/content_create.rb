#
# Copyright 2013 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

module Actions
  module Katello
    module Candlepin
      class ContentCreate < Dynflow::Action

        include Helpers::CandlepinAction

        input_format do
          param :cp_user
          param :repository_id, Integer
          param :environment_cp_id, String
          param :product_cp_id, String
          param :label, String
          param :name, String
          param :content_url, String
          param :gpg_url, String
        end

        output_format do
          param :cp_id, String
        end

        def plan(input)
          content_created = plan_self(input)
          plan_action(Candlepin::ContentAddToProduct,
                      'cp_user'       => User.current.cp_user,
                      'product_cp_id' => input['product_cp_id'],
                      'content_cp_id' => content_created.output['cp_id'])
        end

        def run
          as_cp_user do
            content = Resources::Candlepin::Content.create(:label => input['label'],
                                                           :name => input['name'],
                                                           :contentUrl => input['content_url'],
                                                           :gpgUrl => input['gpg_url'],
                                                           :type => "yum",
                                                           :vendor => Provider::CUSTOM)
            output['cp_id'] = content['id']
          end
        end

        def finalize(*steps)
          repo = Repository.find(input['repo_id'])
          repo.update_attributes!(:content_id => output['cp_id'])
        end

      end
    end
  end
end
