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
      class ContentAddToProduct < Dynflow::Action

        input_format do
          param :product_cp_id, String
          param :content_created, Candlepin::ContentCreate.output
        end

        def run
          Resources::Candlepin::Product.add_content(input['product_cp_id'],
                                                    input['content_created']['cp_id'], true)

          new_content = ::Candlepin::ProductContent.new({
            :content => {
            },
            :enabled => true
                                                        })
          Resources::Candlepin::Content.create(:label => input['label'],
                                               :name => input['name'],
                                               :contentUrl => input['content_url'],
                                               :type => "yum",
                                               :vendor => Provider::CUSTOM)
          self.product.add_content new_content
          self.content_id = new_content.content.id
          self.cp_label = new_content.content.label
          new_content.content
        end

      end
    end
  end
end
