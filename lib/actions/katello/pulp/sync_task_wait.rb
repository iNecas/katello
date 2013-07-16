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
    module Pulp
      class SyncTaskWait < Dynflow::Action

        input_format do
          param :sync_task_created, Pulp::SyncTaskCreate.output
        end

        output_format do
          param :state, String
          param :finish_time
          param :progress
        end

        def run
          task_id = input['sync_task_created']['task_id']

          pulp_task = nil

          while true
            pulp_task = Runcible::Resources::Task.poll(task_id)
            break if pulp_task[:finish_time]
            sleep 1
          end

          output['finish_time'] = pulp_task[:finish_time]
        end

      end
    end
  end
end
