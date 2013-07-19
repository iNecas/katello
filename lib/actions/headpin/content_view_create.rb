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
    class ContentViewCreate < Dynflow::Action

      def plan(content_view)
        content_view.save!
        library_env = content_view.organization.library
        library_view_env = content_view.add_environment(library_env)

        version = ContentViewVersion.create!(:content_view => content_view,
                                             :version => 1) do |v|
          v.content_view_version_environments.build(:environment => library_env)
        end
        plan_action(ContentViewEnvironmentCreate, library_view_env)
        plan_action(ElasticSearch::IndexUpdate, content_view)
      end

    end
  end
end
