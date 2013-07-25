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
      class ProductCreate < Dynflow::Action

        include Helpers::CandlepinAction

        input_format do
          param :cp_user
          param :product_id, Integer
          param :name, String
          param :multiplier, Integer
        end

        output_format do
          param :cp_id, String
        end

        def run
          as_cp_user do
            cp_attributes = [{ :name => "arch", :value => "ALL" }]

            product = Resources::Candlepin::Product.create(:name => input['name'],
                                                           :multiplier => input['multiplier'],
                                                           :attributes => cp_attributes)
            output['cp_id'] = product[:id]
          end
        end

        def finalize(*steps)
          product = Product.find(input['product_id'])
          product.update_attributes!('cp_id' => output['cp_id'])
        end

      end
    end
  end
end
