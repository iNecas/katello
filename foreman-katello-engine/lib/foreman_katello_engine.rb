module ForemanKatelloEngine
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require 'foreman_katello_engine/engine'
  end
end
