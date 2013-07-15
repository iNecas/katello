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
    class RepositoryCreate < Dynflow::Action

      def plan(repo)
        library = repo.product.library
        repo.pulp_id = repo.product.repo_id(repo.label)
        repo.relative_path = Glue::Pulp::Repos.custom_repo_path(library,
                                                                repo.product,
                                                                repo.label)
        # NG_TODO: default content view for library missnig is blocker here!
        repo.content_view_version = library.default_content_view_version
        repo.save!

        plan_action(Candlepin::ContentCreate,
                    'repo_id' => repo.id,
                    'environment_cp_id' => library.cp_id,
                    'product_cp_id' => repo.product.cp_id,
                    'label' => repo.custom_content_label,
                    'name' => repo.name,
                    'content_url' => Glue::Pulp::Repos.custom_content_path(repo.product, repo.label),
                    'gpg_url' => repo.yum_gpg_key_url)

        plan_action(Pulp::RepositoryCreate,
                    'pulp_id' => repo.pulp_id,
                    'name' => repo.name,
                    'content_type' => repo.content_type,
                    'feed_ca' => repo.feed_ca,
                    'feed_cert' => repo.feed_cert,
                    'feed_url' => repo.feed)

        plan_self('id' => repo.id,
                  'label' => repo.label,
                  'name' => repo.name,
                  'product_label' => repo.product.label,
                  'provider_label' => repo.product.provider.label,
                  'organization_label' => repo.organization.label)
      end

    end
  end
end
