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
    class ContentViewPublish < Dynflow::Action

      def plan(view)
        library = view.organization.library

        sequence do
          concurrence do
            if view.new_record?
              plan_action(Headpin::ContentViewCreate, view)
              version = view.version(library)
            else
              next_version_id = view.versions.maximum(:version) + 1
              # NG_TODO: create new version based on the old one
              # version =
            end
            view.definition.repos.map do |repo|
              repo_preparation = sequence do
                plan_action(RepositoryClone, repo, library, view)
                # NG_TODO: unassociate_contents
                # plan_action(RepositoryUnassociateContent, repo, filterns)
              end
            end
          end

          view_cp_env = view.content_view_environments.
            where(:environment_id => library.id).first
          content_ids = view.repos(library).select(&:enabled).map(&:content_id).uniq
          plan_action(Headpin::Candlepin::EnvironmentUpdate,
                      'cp_user' => User.current.cp_user,
                      'cp_id' => view_cp_env.cp_id,
                      'content_ids' => content_ids)
        end

      end

    end
  end
end
