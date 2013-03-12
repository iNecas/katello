require 'katello_api'

module ForemanKatelloEngine
  module Bindings

    class << self

      def initialize_settings
        # proceed only if db set up correctly
        Setting.first rescue return
        [
         Foreman::DefaultSettings::Loader.set('katello_url', 'url of a Katello instance', 'https://localhost/katello')
        ].each { |s| Foreman::DefaultSettings::Loader.create(s.update(:category => "General")) }
      end

      def client_config
        {
          :base_url => Setting['katello_url'],
          :enable_validations => false,
          :oauth => {
            :consumer_key => Setting['oauth_consumer_key'],
            :consumer_secret => Setting['oauth_consumer_secret']
          }
        }
      end

      def environment
        KatelloApi::Resources::Environment.new(client_config)
      end

      def activation_key
        KatelloApi::Resources::ActivationKey.new(client_config)
      end

      def activation_keys_to_subscriptions(org_name, env_name)
        environments, _ = self.environment.index('organization_id' => org_name, :name => env_name)
        if environment = environments.first
          activation_keys, _ = self.activation_key.index('environment_id' => environment['id'])
          return activation_keys.reduce({}) do |h, ak|
            h.update(ak['name'] => ak['pools'].map { |pool| pool['subscription'] })
          end
        else
          return nil
        end
      end

    end
  end

end


