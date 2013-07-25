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
    class RepositorySync < Dynflow::Action

      input_format do
        param :id, Integer
      end

      def plan(repo)
        sync_task_created = plan_action(Pulp::SyncTaskCreate,
                                        'pulp_user' => User.current.pulp_user,
                                        'pulp_id' => repo.pulp_id)
        plan_action(Pulp::TasksWait,
                    'pulp_user' => User.current.pulp_user,
                    'tasks' => [sync_task_created.output])
        plan_self('id' => repo.id)
      end

      def finalize(*args)
        repo = Repository.find(input['id'])
        repo.index_content
      end

    end
  end
end
