module ForemanKatelloEngine
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inhereits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    initializer 'foreman_katello_engine.helper' do |app|
      ActionView::Base.send :include, ForemanKatelloEngine::HostsAndHostgroupsHelper
    end

  end
end
