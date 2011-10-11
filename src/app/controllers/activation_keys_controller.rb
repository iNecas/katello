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

class ActivationKeysController < ApplicationController
  include AutoCompleteSearch
  include ActivationKeysHelper

  before_filter :require_user
  before_filter :find_activation_key, :only => [:show, :edit, :update, :destroy,
                                                :available_subscriptions, :applied_subscriptions,
                                                :add_subscriptions, :remove_subscriptions]
  before_filter :find_environment, :only => [:edit]
  before_filter :authorize #after find_activation_key, since the key is required for authorization
  before_filter :panel_options, :only => [:index, :items]
  before_filter :search_filter, :only => [:auto_complete_search]

  respond_to :html, :js

  def section_id
    'systems'
  end

  def rules
    read_test = lambda{ActivationKey.readable?(current_organization)}
    manage_test = lambda{ActivationKey.manageable?(current_organization)}
    {
      :index => read_test,
      :items => read_test,
      :show => read_test,
      :auto_complete_search => read_test,

      :new => manage_test,
      :create => manage_test,

      :edit => read_test,
      :update => manage_test,

      :available_subscriptions => read_test,
      :applied_subscriptions => read_test,

      :add_subscriptions => manage_test,
      :remove_subscriptions => manage_test,

      :destroy => manage_test
    }
  end

  def index
    begin
      @activation_keys = ActivationKey.search_for(params[:search]).where(:organization_id => current_organization).limit(current_user.page_size)
      retain_search_history
    rescue Exception => error
      errors error.to_s, {:level => :message, :persist => false}
      @activation_keys = ActivationKey.search_for('')
      render :index, :status => :bad_request and return
    end
  end

  def items
    start = params[:offset]
    @activation_keys = ActivationKey.search_for(params[:search]).where(:organization_id => current_organization).limit(current_user.page_size).offset(start)
    render_panel_items @activation_keys, @panel_options
  end

  def show
    render :partial=>"common/list_update", :locals=>{:item=>@activation_key, :accessor=>"id", :columns=>['name']}
  end

  def available_subscriptions
    all_pools = retrieve_all_pools
    available_pools = retrieve_available_pools(all_pools).sort

    render :partial=>"available_subscriptions", :layout => "tupane_layout",
           :locals => {:akey => @activation_key, :editable => ActivationKey.manageable?(current_organization),
                       :available_subs => available_pools}
  end

  def applied_subscriptions
    all_pools = retrieve_all_pools
    applied_pools = retrieve_applied_pools(all_pools).sort

    render :partial=>"applied_subscriptions", :layout => "tupane_layout",
           :locals => {:akey => @activation_key, :editable => ActivationKey.manageable?(current_organization),
                       :applied_subs => applied_pools}
  end

  def add_subscriptions
    # In the current UI, the user does not provide an 'allocated' value for subscriptions.  Instead, they select
    # the subscription and the intent is that during system registration the 'auto-subscribe' capability will
    # be used to ensure proper subscriptions are assigned to the system. The backend currently needs this value;
    # therefore, we are setting it to 1.  It can be refactored out, once backend no longer needs it.
    allocated = "1"
    begin
      if params.has_key? :subscription_id
        params[:subscription_id].keys.each do |pool|
          kt_pool = KTPool.where(:cp_id => pool)[0]

          if kt_pool.nil?
            KTPool.create!(:cp_id => pool, :key_pools => [KeyPool.create!(:allocated=> allocated, :activation_key => @activation_key)])
          else
            key_sub = KeyPool.where(:activation_key_id => @activation_key.id, :pool_id => kt_pool.id)[0]

            if key_sub
              key_sub.allocated = allocated
              key_sub.save!
            else
              KeyPool.create!(:activation_key_id => @activation_key.id, :pool_id => kt_pool.id, :allocated => allocated)
            end
          end
        end
      end
      notice _("Subscriptions successfully added to Activation Key '#{@activation_key.name}'.")
      render :partial => "available_subscriptions_update.js.haml"

    rescue Exception => error
      errors error.to_s
      render :nothing => true
    end
  end

  def remove_subscriptions
    begin
      if params.has_key? :subscription_id
        params[:subscription_id].keys.each do |pool|
          kt_pool = KTPool.where(:cp_id => pool)[0]

          if kt_pool
            key_sub = KeyPool.where(:activation_key_id => @activation_key.id, :pool_id => kt_pool.id)[0]

            if key_sub
              key_sub.destroy
            end
          end
        end
      end
      notice _("Subscriptions successfully removed from Activation Key '#{@activation_key.name}'.")
      render :partial => "applied_subscriptions_update.js.haml"

    rescue Exception => error
      errors error.to_s
      render :nothing => true
    end
  end

  def new
    activation_key = ActivationKey.new

    @organization = current_organization
    accessible_envs = current_organization.environments
    setup_environment_selector(current_organization, accessible_envs)
    @environment = first_env_in_path(accessible_envs)

    @system_template_labels = [[no_template, '']]
    unless @environment.nil?
      @system_template_labels = [[no_template, '']] + (@environment.system_templates).collect {|p| [ p.name, p.id ]}
    end

    @selected_template = no_template

    render :partial => "new", :layout => "tupane_layout", :locals => {:activation_key => activation_key,
                                                                      :accessible_envs => accessible_envs}
  end

  def edit
    @organization = current_organization
    accessible_envs = current_organization.environments
    setup_environment_selector(current_organization, accessible_envs)

    @system_template_labels = [[no_template, '']]
    unless @environment.nil?
      @system_template_labels = [[no_template, '']] + (@activation_key.environment.system_templates).collect {|p| [ p.name, p.id ]}
    end
    @selected_template = @activation_key.system_template.nil? ? no_template : @activation_key.system_template.id

    render :partial => "edit", :layout => "tupane_layout", :locals => {:activation_key => @activation_key,
                                                                       :editable => ActivationKey.manageable?(current_organization),
                                                                       :name => controller_display_name,
                                                                       :accessible_envs => accessible_envs}
  end

  def create
    @activation_key = ActivationKey.create!(params[:activation_key]) do |key|
      key.organization = current_organization
      key.user = current_user
    end
    notice _("Activation key '#{@activation_key['name']}' was created.")
    
    if ActivationKey.where(id = @activation_key.id).search_for(params[:search]).include?(@activation_key)
      render :partial=>"common/list_item", :locals=>{:item=>@activation_key, :accessor=>"id", :columns=>['name'], :name=>controller_display_name}
    else
      render :json => { :no_match => true }
    end
  rescue Exception => error
    Rails.logger.error error.to_s
    errors error
    render :text => error, :status => :bad_request
  end

  def update
    result = params[:activation_key].nil? ? "" : params[:activation_key].values.first

    begin
      unless params[:activation_key][:description].nil?
        result = params[:activation_key][:description] = params[:activation_key][:description].gsub("\n",'')
      end

      if !params[:activation_key][:system_template_id].nil? and params[:activation_key][:system_template_id].blank?
        params[:activation_key][:system_template_id] = nil
      end

      @activation_key.update_attributes!(params[:activation_key])

      notice _("Activation key '#{@activation_key["name"]}' was updated.")

      unless params[:activation_key][:system_template_id].nil? or params[:activation_key][:system_template_id].blank?
        # template is being updated.. so return template name vs id...
        system_template = SystemTemplate.find(@activation_key.system_template_id)
        result = system_template.name
      end

      render :text => escape_html(result)

    rescue Exception => error
      errors error

      respond_to do |format|
        format.js { render :partial => "layouts/notification", :status => :bad_request, :content_type => 'text/html' and return}
      end
    end
  end

  def destroy
    begin
      @activation_key.destroy
      if @activation_key.destroyed?
        notice _("Activation key '#{@activation_key[:name]}' was deleted.")
        #render and do the removal in one swoop!
        render :partial => "common/list_remove", :locals => {:id=>params[:id], :name=>controller_display_name}
      else
        raise
      end
    rescue Exception => e
      errors e.to_s
    end
  end

  protected

  def find_activation_key
    begin
      @activation_key = ActivationKey.find(params[:id])
    rescue Exception => error
      errors error.to_s

      # flash_to_headers is an after_filter executed on the application controller;
      # however, a render from within a before_filter will halt the filter chain.
      # as a result, we are explicitly executing it here.
      flash_to_headers

      render :text => error, :status => :bad_request
    end
  end

  def find_environment
    @environment = @activation_key.environment
  end

  def panel_options
    @panel_options = { 
      :title => _('Activation Keys'),
      :col => ['name'],
      :create => _('Key'), 
      :name => controller_display_name,
      :ajax_load  => true,
      :ajax_scroll => items_activation_keys_path(),
      :enable_create => ActivationKey.manageable?(current_organization)}
  end

  private

  require 'ostruct'

  # Using the list of pools provided, create a list of the ones that are 'available' (i.e. not already consumed/applied).
  # The result will be a hash where the key is the product name and the value is an array of hashes where each entry
  # in the array is for a pool and the elements of the hash are details for that pool
  def retrieve_available_pools all_pools
    available_pools = all_pools.clone

    # remove pools that have been consumed from the list
    consumed = @activation_key.pools
    consumed.each do |pool|
      available_pools.delete(pool.cp_id)
    end

    pools_hash available_pools
  end

  # Using the list of pools provided, create a list of the ones that have been applied.
  # The result will be a hash where the key is the product name and the value is an array of hashes where each entry
  # in the array is for a pool and the elements of the hash are details for that pool
  def retrieve_applied_pools all_pools
    # using the list of pools provided, create a list of the ones that have been applied
    applied_pools = {}

    # build a list of applied/consumed pools using the data associated with the key and
    # the pool details retrieved from candlepin.
    consumed = @activation_key.pools
    consumed.each do |pool|
      applied_pools[pool.cp_id] = all_pools[pool.cp_id]
    end

    pools_hash applied_pools
  end

  # Iterate the pools provided creating a hash where the key is the product name and the value is an array
  # of pool entries.
  def pools_hash pools
    pools_return = {}
    pools.each do |poolId, pool|
      pools_return[pool.productName] ||= []
      pools_return[pool.productName] << pool
    end
    pools_return
  end

  def retrieve_all_pools
    all_pools = {}

    cp_pools = Candlepin::Owner.pools current_organization.cp_key
    cp_pools.each do |pool|
      p = OpenStruct.new
      p.poolId = pool['id']
      p.productName = pool['productName']
      p.startDate = Date.parse(pool['startDate']).strftime("%m/%d/%Y")
      p.endDate = Date.parse(pool['endDate']).strftime("%m/%d/%Y")

      p.poolType = _('Physical')
      if pool.has_key? :attributes
        pool[:attributes].each do |attribute|
          name = attribute[:name]
          if (name == 'virt_only')
            if (attribute[:value] == 'true')
              p.poolType = _('Virtual')
            end
            break
          end
        end
      end

      all_pools[p.poolId] = p if !all_pools.include? p
    end
    all_pools
  end

  def controller_display_name
    return _('activation_key')
  end

  def search_filter
    @filter = {:organization_id => current_organization}
  end

end
