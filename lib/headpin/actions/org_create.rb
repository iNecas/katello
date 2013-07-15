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

module Headpin
  module Actions
    class OrgCreate < Dynflow::Action

      def plan(organization)
        organization.save!

        plan_action(Candlepin::OwnerCreate,
                    'name' => organization.name,
                    'label' => organization.label)
        plan_action(EnvironmentCreate, organization.library)
        organization.providers.each do |provider|
          plan_action(ProviderCreate, provider)
        end

        plan_action(ElasticSearch::IndexUpdate, organization)

        plan_self('id' => organization.id,
                  'name' => organization.name,
                  'label' => organization.label)
      end

      input_format do
        param :id, Integer
        param :name, String
        param :label, String
      end

    end
  end
end
