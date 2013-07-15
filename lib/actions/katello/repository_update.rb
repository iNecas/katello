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
    class RepositoryUpdate < Dynflow::Action

      def plan(repository)
        #should_update_content?(repository)
          #plan_action(Candlepin::ContentUpdate)
        #end
      end

      def should_update_content?(repository)
        # NG_TODO: we can do better :)
        (repository.gpg_key_id_was == nil &&
         repository.gpg_key_id != nil &&
         repository.content.gpgUrl == '') ||
          (repository.gpg_key_id_was != nil &&
           repository.gpg_key_id == nil &&
           repository.content.gpgUrl != '')
      end

    end
  end
end
