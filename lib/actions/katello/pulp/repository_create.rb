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

        include Helpers::PulpAction

        input_format do
          param :pulp_user
          param :pulp_id, String
          param :name, String
          param :content_type, String
          param :relative_path, String
          param :unprotected, :bool
          param :feed_ca, String
          param :feed_cert, String
          param :feed_key, String
          param :feed_url, String
        end

        output_format do
          param :pulp_id
        end

        def plan(repo)
          plan_self('pulp_user' => User.current.pulp_user,
                    'pulp_id' => repo.pulp_id,
                    'name' => repo.name,
                    'content_type' => repo.content_type,
                    'relative_path' => repo.relative_path,
                    'unprotected' => repo.unprotected,
                    'feed_ca' => repo.feed_ca,
                    'feed_cert' => repo.feed_cert,
                    'feed_url' => repo.feed)
        end

        def run
          as_pulp_user do
            importer = generate_importer

            distributors = [generate_distributor]

            Runcible::Extensions::Repository.
                create_with_importer_and_distributors(input['pulp_id'],
                                                      importer,
                                                      distributors,
                                                      { :display_name => input['name'] })

            # NG_TODO: to be able to chain this action
            output['pulp_id'] = input['pulp_id']
          end
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

        def generate_distributor
          case input['content_type']
          when Repository::YUM_TYPE
            Runcible::Extensions::YumDistributor.new(input['relative_path'],
                                                     (input['unprotected'] || false),
                                                     true,
                                                     {:protected => true,
                                                       :id => input['pulp_id'],
                                                       :auto_publish => true})
          when Repository::FILE_TYPE
            dist = Runcible::Extensions::IsoDistributor.new(true, true)
            dist.auto_publish = true
            dist
          else
            raise _("Unexpected repo type %s") % input['content_type']
          end

        end

      end
    end
  end
end
