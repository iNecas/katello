#
# Copyright 2014 Red Hat, Inc.
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
  class BulkAction < Actions::Base

    include Actions::Composition

    def plan(action_class, args_set)
      start = Time.now
      args_set.each do |args|
        repo = args
        action_logger.debug("====== #{repo.name} plan started")
        sub_plan(action_class, *args)
        action_logger.debug("====== #{repo.name} plan finished")
      end
      finish = Time.now
      action_logger.debug("====== Creating #{args_set.size} repos took us #{finish - start}")
    end
  end
end
