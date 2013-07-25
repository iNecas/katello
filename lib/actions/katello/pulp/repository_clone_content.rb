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
      class RepositoryCloneContent < Dynflow::Action

        include Helpers::PulpAction

        input_format do
          param :pulp_user
          param :origin_repo_id
          param :cloned_repo_id
        end

        output_format do
          param :tasks, Array do
            param :task_id
          end
        end

        def run
          origin_id = input['origin_repo_id']
          cloned_id = input['cloned_repo_id']
          tasks = []

          as_pulp_user do

            # In order to reduce the memory usage of pulp during the copy process,
            # include the fields that will uniquely identify the rpm. If no fields
            # are listed, pulp will retrieve every field it knows about for the rpm
            # (e.g. changelog, filelist...etc).
            tasks << Runcible::Extensions::Rpm.copy(origin_id, cloned_id,
                                                    { :fields => Package::PULP_SELECT_FIELDS })
            tasks << Runcible::Extensions::Distribution.copy(origin_id, cloned_id)

            # Since the rpms will be copied above, during the copy of errata and package groups,
            # include the copy_children flag to request that pulp skip copying them again.
            tasks << Runcible::Extensions::Errata.copy(origin_id, cloned_id,
                                                       { :copy_children => false })
            tasks << Runcible::Extensions::PackageGroup.copy(origin_id, cloned_id,
                                                             { :copy_children => false })
            tasks << Runcible::Extensions::YumRepoMetadataFile.copy(origin_id, cloned_id)

            output['tasks'] = tasks.map { |t| { 'task_id' => t['task_id']} }
          end
        end

      end
    end
  end
end
