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
    class RepositoryClone < Dynflow::Action

      input_format do
        param :tasks, Pulp::TasksWait.output
      end

      def plan(repo, to_env, content_view)
        sequence do
          repo_clone = content_view.get_repo_clone(to_env, repo).first
          unless repo_clone
            repo_clone = repo.create_clone(to_env, content_view)
            cloned_repo = plan_action(Pulp::RepositoryCreate, repo_clone).output
          end

          # NG_TODO: raise exeception here and try to resume: fail on deps
          clone_action = plan_action(Pulp::RepositoryCloneContent,
                                     'origin_repo' => { 'pulp_id' => repo.pulp_id },
                                     'cloned_repo' => { 'pulp_id' => repo_clone.pulp_id})

          # NG_TODO: be able to reference subkey
          tasks_wait_action = plan_action(Pulp::TasksWait, 'tasks' => clone_action.output)
          # NG_TODO: we really don't care about tasks here, just want to
          # make sure we wait for tasks before proceeding
          # this can be also postponed after another actions on the repo
          # (such as repos unassociation)
          metadata_action = plan_action(Pulp::RepositoryGenerateMetadata,
                                        'repo' => cloned_repo,
                                        'tasks' => tasks_wait_action.output)
          tasks_wait_action = plan_action(Pulp::TasksWait, 'tasks' => metadata_action.output)
        end
      end

    end
  end
end
