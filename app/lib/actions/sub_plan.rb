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
  class SubPlan < Actions::ExecutePlan

    include Actions::Composition

    protected

    # Override to create sub plan to be executed
    def sub_plan
      # create_sub_plan(ActionClass, arg1, arg2, arg3)
      raise NotImplementedError
    end

    def sub_plan_id
      output[:sub_plan_id] = sub_plan.id
    end

    def async?
      input.has_key?(:async) ? input[:async] : false
    end

  end
end
