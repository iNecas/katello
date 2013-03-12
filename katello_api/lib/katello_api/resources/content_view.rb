module KatelloApi
  module Resources
    class ContentView < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["content_views"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  content view id 
      # @option params [String] environment_id  environment identifier 
      # @option params [String] label  content view label 
      # @option params [String] name  content view name 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/content_views", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  content view id 
      # @option params [String] environment_id  environment id 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_views/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  content view id 
      # @option params [String] environment_id  environment promoting to 
      #
      # @param [Hash] headers additional http headers
      def promote(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_views/:id/promote", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def refresh(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/content_views/:id/refresh", params
        call(:"post", url, params, headers)
      end

    end
  end
end
