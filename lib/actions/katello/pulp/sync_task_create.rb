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
      class SyncTaskCreate < Dynflow::Action

        input_format do
          param :pulp_id, String
        end

        output_format do
          param :task_id
        end

        def run
          sync_options = {}
          sync_options[:max_speed] ||= ::Katello.config.pulp.sync_KBlimit if ::Katello.config.pulp.sync_KBlimit # set bandwidth limit
          sync_options[:num_threads] ||= ::Katello.config.pulp.sync_threads if ::Katello.config.pulp.sync_threads # set threads per sync
          pulp_tasks = Runcible::Extensions::Repository.sync(input['pulp_id'], {:override_config=>sync_options})
          pulp_task = pulp_tasks.find do |task|
            task['tags'].include?("pulp:action:sync")
          end
          output['task_id'] = pulp_task['task_id']
        end

      end
    end
  end
end
