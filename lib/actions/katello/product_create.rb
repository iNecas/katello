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
    class ProductCreate < Dynflow::Action

      def plan(product)
        product.save!

        product_created = plan_action(Candlepin::ProductCreate,
                                      'cp_user' => User.current.cp_user,
                                      'product_id' => product.id,
                                      'name' => product.name,
                                      'multiplier' => product.multiplier)
        plan_action(Candlepin::ProductToOrganization,
                    :cp_user  => User.current.cp_user,
                    :cp_id    => product_created.output[:cp_id],
                    :cp_owner => product.organization.label)

        plan_action(ElasticSearch::IndexUpdate, product)
        plan_action(ElasticSearch::IndexUpdate, product.provider)
      end

    end
  end
end
