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

class Api::V1::SystemGroupSubscriptionsController < Api::V1::ApiController
  resource_description do
    description <<-DOC
      methods for handling packages on system group level
    DOC

    param :organization_id, :identifier, :desc => "oranization identifier", :required => true
    param :system_group_id, :identifier, :desc => "system_group identifier", :required => true

    api_version 'v1'
    api_version 'v2'
  end

  respond_to :json

  before_filter :find_group, :only => [:create, :update, :destroy]
  before_filter :authorize

  def rules
    edit_systems = lambda { @group.systems_editable? }

    {
        :create  => edit_systems,
        :update  => edit_systems,
        :destroy => edit_systems,
    }
  end

  api :POST, "/organizations/:organization_id/system_groups/:system_group_id/subscriptions", "Install packages remotely"
  param :pools, Array
  def create
    task_id, _ = async_action(::Actions::Headpin::SystemGroupSubscribe, @group, params[:pools])
    render :json => { task_id: task_id }
  end

  protected

  def find_group
    @group = SystemGroup.find(params[:system_group_id])
    raise HttpErrors::NotFound, _("Couldn't find system group '%s'") % params[:system_group_id] if @group.nil?
    @group
  end

end
