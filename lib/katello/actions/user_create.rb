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

module Katello
  module Actions
    class UserCreate < Dynflow::Action

      def self.subscribe
        Headpin::Actions::UserCreate
      end

      def plan(user)
        pulp_user_create = plan_action(Pulp::UserCreate, 'remote_id' => user.remote_id)
        plan_action(Pulp::UserSetSuperuser,
                    'remote_id' => user.remote_id,
                    'created' => pulp_user_create.output)
        # we add the output of the previous action just for ordering
        # purposes.
        # NG_TODO: add the orderging DSL to Dynflow
      end

    end
  end
end
