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
  class ExecutePlan < Dynflow::Action

    input_format do
      param :sub_plan_id
      param :async
    end

    def run(event = nil)
      match(event,
            (on nil do
               execution = world.execute(sub_plan_id)
               unless async?
                 suspend do |suspended_action|
                   execution.do_then { suspended_action << execution }
                 end
               end
             end),
            (on Dynflow::Future do
               raise event.value if event.failed?
             end))
    end

    protected

    def sub_plan_id
      input[:sub_plan_id]
    end

    def async?
      input.has_key?(:async) ? input[:async] : false
    end

  end
end
