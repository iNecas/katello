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

class Api::ProvidersController < Api::ApiController

  before_filter :find_organization, :only => [:index, :create]
  before_filter :find_provider, :only => [:show, :update, :destroy, :products, :import_products, :refresh_products, :import_manifest, :product_create]
  before_filter :authorize

  def rules
    index_test = lambda{Provider.any_readable?(@organization)}
    create_test = lambda{Provider.creatable?(@organization)}
    read_test = lambda{@provider.readable?}
    edit_test = lambda{@provider.editable?}
    delete_test = lambda{@provider.deletable?}
    {
      :index => index_test,
      :show => index_test,

      :create => create_test,
      :update => edit_test,
      :destroy => delete_test,

      :products => read_test,
      :import_manifest => edit_test,
      :import_products => edit_test,
      :refresh_products => edit_test,
      :product_create => edit_test,
    }
  end

  def param_rules
    {
      :create => {:provider  => [:name, :description, :provider_type, :repository_url]},
      :update => {:provider  => [:name, :description, :repository_url]}
    }
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :GET, "/organizations/:organization_id/providers", "List providers"
  param :name, String
  param :organization_id, :identifier, :required => true
  def index
    query_params.delete(:organization_id)
    render :json => (Provider.readable(@organization).where query_params).to_json
  end

  def show
    render :json => @provider.to_json
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :POST, "/providers", "Create a provider"
  param :organization_id, :identifier
  param :provider, Hash do
    param :description, String, :allow_nil => true
    param :name, String
    param :provider_type, String
    param :repository_url, String
  end
  def create
    provider = Provider.create!(params[:provider]) do |p|
      p.organization = @organization
    end
    render :json => provider.to_json and return
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :PUT, "/providers/:id", "Update a provider"
  param :id, :number, :required => true
  param :provider, Hash do
    param :repository_url, String
  end
  def update
    @provider.update_attributes!(params[:provider])
    render :json => @provider.to_json and return
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :DELETE, "/providers/:id", "Destroy a provider"
  param :id, :number, :required => true
  def destroy
    @provider.destroy
    if @provider.destroyed?
      render :text => _("Deleted provider [ %s ]") % @provider.name , :status => 200
    else
      raise HttpErrors::ApiError, _("Error while deleting provider [ %s ]: %s") % [@provider.name, @provider.errors.full_messages]
    end
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :GET, "/providers/:id/products", "TODO: Describe API"
  param :id, :number, :required => true
  def products
    render :json => @provider.products.all_readable(@provider.organization).select("products.*, providers.name AS provider_name").joins(:provider).to_json
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :POST, "/providers/:id/import_manifest", "TODO: Describe API"
  param :force, String
  param :id, :number, :required => true
  param :import, ActionDispatch::Http::UploadedFile
  def import_manifest
    if @provider.yum_repo?
      raise HttpErrors::BadRequest, _("It is not allowed to import manifest for a custom provider.")
    end

    begin
      temp_file = File.new(File.join("#{Rails.root}/tmp", "import_#{SecureRandom.hex(10)}.zip"), 'w+', 0600)
      temp_file.write params[:import].read
    ensure
      temp_file.close
    end

    @provider.import_manifest File.expand_path(temp_file.path), :force => params[:force]
    render :text => "Manifest imported", :status => 200
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :POST, "/providers/:id/refresh_products", "TODO: Describe API"
  param :id, :number, :required => true
  def refresh_products
    raise HttpErrors::BadRequest, _("It is not allowed to refresh products for custom provider.") unless @provider.redhat_provider?

    @provider.refresh_products
    render :text => _("Products refreshed from CDN"), :status => 200
  end

  def import_products
    results = params[:products].collect do |p|
      to_create = Product.new(p) do |product|
        product.provider = @provider
        product.organization = @provider.organization
      end
      to_create.save!
    end
    render :json => results.to_json
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENARATING NEXT TIME
  api :POST, "/providers/:id/product_create", "TODO: Describe API"
  param :id, :number, :required => true
  param :product, Hash do
    param :description, :bool, :allow_nil => true
    param :gpg_key_name, String, :allow_nil => true
    param :name, String
  end
  def product_create
    raise HttpErrors::BadRequest, _("It is not allowed to create products in Red Hat provider.") if @provider.redhat_provider?

    product_params = params[:product]
    gpg  = GpgKey.readable(@provider.organization).find_by_name!(product_params[:gpg_key_name]) unless product_params[:gpg_key_name].blank?
    prod = @provider.add_custom_product(product_params[:name], product_params[:description], product_params[:url], gpg)
    render :json => prod
  end

  private

  def find_provider
    @provider = Provider.find(params[:id])
    @organization ||= @provider.organization
    raise HttpErrors::NotFound, _("Couldn't find provider '%s'") % params[:id] if @provider.nil?
  end

end
