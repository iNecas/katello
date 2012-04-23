#
# Copyright 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.

class Api::CandlepinProxiesController < Api::ProxiesController

  skip_before_filter :authorize # ok - proxy is consumer only

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :GET, "/consumers/:id/certificates", "TODO: Describe API"
  api :GET, "/consumers/:id/certificates/serials", "TODO: Describe API"
  api :GET, "/consumers/:id/entitlements", "TODO: Describe API"
  api :GET, "/consumers/:id/owner", "TODO: Describe API"
  api :GET, "/consumers/:id/release", "TODO: Describe API"
  api :GET, "/entitlements/:id", "TODO: Describe API"
  api :GET, "/owners/:organization_id/pools", "TODO: Describe API"
  api :GET, "/owners/:organization_id/servicelevels", "TODO: Describe API"
  api :GET, "/pools", "TODO: Describe API"
  param :activeon, String
  param :consumer, String
  param :id, :identifier
  param :listall, String
  param :organization_id, :identifier
  param :serials, String
  error :code => 410
  def get
    r = ::Resources::Candlepin::Proxy.get(@request_path)
    Rails.logger.debug r if AppConfig.debug_cp_proxy
    render :text => r, :content_type => :json
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :DELETE, "/consumers/:consumer_id/certificates/:id", "TODO: Describe API"
  api :DELETE, "/consumers/:id/entitlements", "TODO: Describe API"
  param :consumer_id, :identifier
  param :id, :identifier, :required => true
  def delete
    head ::Resources::Candlepin::Proxy.delete(@request_path).code.to_i
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :POST, "/consumers/:id/entitlements", "TODO: Describe API"
  api :POST, "/subscriptions", "TODO: Describe API"
  param :id, :identifier
  param :pool, String
  def post
    r = ::Resources::Candlepin::Proxy.post(@request_path, @request_body)
    Rails.logger.debug r if AppConfig.debug_cp_proxy
    render :text => r, :content_type => :json
  end
  
end
