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
  module Katello
    module ContentView
      class Publish < Actions::AbstractAsyncTask

        def plan(content_view, notify = false)
          # this is a simple replacement of previous usage of delayed jobs
          # TODO: extract the REST calls from ContentView#publis
          # and construct proper execution plan
          if !content_view.ready_to_publish?
            fail _("Cannot publish view. Check for repository conflicts.")
          end

          version = content_view.create_new_version
          action_subject version
          plan_self(content_view_version_id: version.id,
                    notify: notify)
        end

        input_format do
          param :content_view_version, Hash do
            param :id
          end
          param :notify
        end

        def humanized_name
          _("Publish")
        end

        def run
          version = ::Katello::ContentViewVersion.find(input[:content_view_version][:id])
          version.content_view.publish_content(version, input[:notify])
        end

      end
    end
  end
end
