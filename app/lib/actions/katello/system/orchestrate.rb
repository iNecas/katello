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
    module System
      class Orchestrate < Actions::EntryAction

          include Helpers::Presenter

          PLAN =  {"sequence"=>
                    [{"Package::Install"=>{"package"=>"redis"}},
                     {"concurrence"=>
                       [{"Service::Restart"=>{"service"=>"redis"}},
                        {"Service::Restart"=>{"service"=>"puppet"}}]}]}

          def plan(system, plan)
            action_subject(system, plan: plan)
            evaluate_plan(plan)
          end

          def evaluate_plan(plan)
            case plan
            when Array
              plan.each { |subplan| evaluate_plan(subplan) }
            else
              key, value = plan.to_a.first
              case key
              when "sequence"
                sequence { evaluate_plan(value) }
              when "concurrence"
                concurrence { evaluate_plan(value) }
              else
                action = "Mcoflow::Actions::#{key}".constantize
                plan_action(action, value.merge(hostname: input[:system][:name]))
              end
            end
          end

          def humanized_name
            _("Orchestrate")
          end

          def presenter
            Helpers::Presenter::DelegatedPresenters.new(self)
          end
        end
      end
    end
end
