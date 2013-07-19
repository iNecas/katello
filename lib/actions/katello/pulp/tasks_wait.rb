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
      class TasksWait < Dynflow::Action

        input_format do
          param :tasks, Array do
            param :task_id
          end
        end

        output_format do
          param :state, String
          param :finish_time
          param :progress
        end

        def run
          pending_task_ids = input['tasks'].map { |task| task['task_id'] }
          pulp_task = nil

          while pending_task_ids.any?
            task_id = pending_task_ids.first
            pulp_task = Runcible::Resources::Task.poll(task_id)
            if pulp_task[:finish_time]
              pending_task_ids.shift
            end
          end

          output['finish_time'] = Time.now.to_s
        end

      end
    end
  end
end
