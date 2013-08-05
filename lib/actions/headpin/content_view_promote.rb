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
    class ContentViewPromote < Dynflow::Action

      def plan(content_view, env)
        unless content_view.in_environment?(env)
          view_env = content_view.add_environment(env)
          plan_action(ContentViewEnvironmentCreate, view_env)
        end

        version = content_view.version(env.prior)
        version.content_view_version_environments.create!(:environment => env)
        plan_action(ElasticSearch::IndexUpdate, content_view)
      end

    end
  end
end
