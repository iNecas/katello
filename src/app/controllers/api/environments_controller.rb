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

class Api::EnvironmentsController < Api::ApiController

  resource_description do
    description <<-EOS
      An environment is a basic organization structure that groups systems,
      products, repositories, templates etc.  Every system belongs to one environment
      and it's isolated inside so that it can see only content that is in its
      environment.

      == Chains

      Environments are ordered into chains and their content (propducts,
      repositories, tempaltes, packages) can be moved to an environment only from its
      prior environment. You can have for example chain like:

        Library -> Development -> Testing -> Production

      Each change in an environment is done through a changeset in an action
      called promotion.

      == Library

      Library is a special environment that has no ascendant: all the content
      starts in this environment. More chains can start from the library environment but
      no further branching of a chain is enabled.
    EOS
  end


  respond_to :json
  before_filter :find_organization, :only => [:index, :create]
  before_filter :find_environment, :only => [:show, :update, :destroy, :repositories, :releases]
  before_filter :authorize
  def rules
    manage_rule = lambda{@organization.environments_manageable?}
    view_rule = lambda{@organization.readable?}

    index_rule = lambda {true}
    # Note: index_rule is always true.
    # Instead we are simply going to filter out the inaccessible environments
    # from the environment list we return. Look at the index method to
    # figure out how that rule is applied.

    {
      :index => index_rule,
      :show => view_rule,
      :create => manage_rule,
      :update => manage_rule,
      :destroy => manage_rule,
      :repositories => view_rule,
      :releases => view_rule
    }
  end


  def param_rules
    manage_match =  {:environment =>  ["name", "description", "prior" ]}

    {
      :create =>manage_match,
      :update => manage_match,
      :index => [:name, :library, :id, :organization_id]
    }
  end


  api :GET, "/organizations/:organization_id/environments", "List and filter environments of an organization"
  api :GET, "/owners/:organization_id/environments"
  param :organization_id, :identifier, :required => true
  param :name, String
  param :library, :bool, :desc => "set true if you search for Library environment"
  def index
    query_params[:organization_id] = @organization.id
     environments = KTEnvironment.where query_params
     unless @organization.readable? || @organization.any_systems_registerable?
       environments.delete_if do |env|
         !env.any_operation_readable?
       end
     end
    render :json => (environments).to_json
  end

  def show
    render :json => @environment
  end

  api :POST, "/organizations/:organization_id/environments", "Create an environment in organization"
  param :organization_id, :identifier, :required => true
  param :environment, Hash do
    param :name, :identifier, :required => true, :desc => "Name of the new environment, it has to be unique in the organization"
    param :prior, :number, :required => true, :desc => "Id of the prior environment. it has to be either Library or an environment at the end of a chain"
    param :description, String
  end
  error :code => 400, :desc => "In case the name is already taken or the prior is neither Library nor environment at the end of the chain"
  desc <<-DESC
  Sample output:

    {"id"=>11,
     "name"=>"Test",
     "library"=>false,
     "prior_id"=>10,
     "prior"=>"Dev",
     "created_at"=>"2012-05-02T11:16:13Z",
     "updated_at"=>"2012-05-02T11:16:13Z",
     "organization_id"=>1,
     "organization"=>"ACME_Corporation",
     "description"=>"Testing environment"}
  DESC

  def create
    environment = KTEnvironment.new(params[:environment])
    @organization.environments << environment
    raise ActiveRecord::RecordInvalid.new(environment) unless environment.valid?
    @organization.save!
    render :json => environment
  end

  api :PUT, "/environments/:id", "Update an environment"
  api :PUT, "/organizations/:organization_id/environments/:id", "Update an environment"
  param :id, :number, :required => true
  param :organization_id, :identifier
  param :environment, Hash do
    param :description, String
  end
  def update
    if @environment.library?
      raise HttpErrors::BadRequest, _("Can't update Library environment")
    else
      @environment.update_attributes!(params[:environment])
      render :json => @environment
    end
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :DELETE, "/environments/:id", "Destroy an environment"
  api :DELETE, "/organizations/:organization_id/environments/:id", "Destroy an environment"
  param :id, :number, :required => true
  param :organization_id, :identifier
  def destroy
    if @environment.confirm_last_env
      @environment.destroy
      render :text => _("Deleted environment '#{params[:id]}'"), :status => 200
    else
      raise HttpErrors::BadRequest,
            _("Environment #{@environment.name} has a successor. Only the last environment on a path can be deleted.")
    end
  end

  api :GET, "/organizations/:organization_id/environments/:id/repositories", "List repositories of the environment"
  param :id, :number, :required => true
  param :organization_id, :identifier, :required => true
  param :include_disabled, :bool, :desc => "By default only enabled repositories are returned. Set to 'true' to see all repositories"
  def repositories
    render :json => @environment.products.all_readable(@organization).collect { |p| p.repos(@environment, query_params[:include_disabled]) }.flatten
  end

  def releases
    render :json => { :releases => @environment.available_releases }
  end


  protected

  def find_environment
    @environment = KTEnvironment.find(params[:id])
    raise HttpErrors::NotFound, _("Couldn't find environment '#{params[:id]}'") if @environment.nil?
    @organization = @environment.organization
    @environment
  end

end
