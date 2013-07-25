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
      class RepositoryGenerateMetadata < Dynflow::Action

        include Helpers::PulpAction

        input_format do
          param :pulp_user
          # NG_TODO: close this into nested hash just because
          # we might chain it with RepositoryCreate
          param :repo, Hash do
            param :pulp_id
          end
        end

        output_format do
          param :tasks, Array do
            param :task_id
          end
        end

        def run
          as_pulp_user do
            pulp_id = input['repo']['pulp_id']
            tasks = Runcible::Extensions::Repository.publish_all(pulp_id)

            output['tasks'] = tasks.map { |t| { 'task_id' => t['task_id']} }
          end
        end
      end
    end
  end
end
