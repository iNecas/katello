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
  module Headpin
    class ProviderCreate < Dynflow::Action

      def plan(provider)
        provider.save!
        plan_self('name' => provider.name,
                  'organization_label' => provider.organization.label)

        plan_action(ElasticSearch::IndexUpdate, provider)
      end

      input_format do
        param :name, String
        param :label, String
        param :organization_label, String
      end

    end
  end
end
