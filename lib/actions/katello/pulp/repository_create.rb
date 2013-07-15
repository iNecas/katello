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
      class RepositoryCreate < Dynflow::Action

        input_format do
          param :pulp_id, String
          param :name, String
          param :content_type, String
          param :feed_ca, String
          param :feed_cert, String
          param :feed_key, String
          param :feed_url, String
        end

        def run
          importer = generate_importer

          distributors = [generate_distributor]

          Runcible::Extensions::Repository.
            create_with_importer_and_distributors(input['pulp_id'],
                                                  importer,
                                                  distributors,
                                                  { :display_name => input['name'] })
        end

        def generate_importer
          importer_class = case input['content_type']
                           when Repository::YUM_TYPE
                             Runcible::Extensions::YumImporter
                           when Repository::FILE_TYPE
                             Runcible::Extensions::IsoImporter
                           else
                             raise _("Unexpected repo type %s") % self.content_type
                           end

          importer_class.new(:ssl_ca_cert => input['feed_ca'],
                             :ssl_client_cert => input['feed_cert'],
                             :ssl_client_key => input['feed_key'],
                             :feed_url => input['feed_url'])
        end

      end
    end
  end
end
