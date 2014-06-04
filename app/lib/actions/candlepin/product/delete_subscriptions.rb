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
  module Candlepin
    module Product
      class DeleteSubscriptions < Candlepin::Abstract
        input_format do
          param :organization_label
          param :cp_id
        end

        def run
          job = ::Katello::Resources::Candlepin::Product.delete_subscriptions(input[:organization_label], input[:cp_id])
          wait_for_job(job) if job
        end

        # preventing of going into race-condition described in BZ_788932 by waiting
        # for each job to finish before proceeding
        def wait_for_job(job)
          while Resources::Candlepin::Job.not_finished?(Resources::Candlepin::Job.get(job[:id]))
            sleep 0.5
          end
        end
      end
    end
  end
end
