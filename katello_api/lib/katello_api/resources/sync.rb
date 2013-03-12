module KatelloApi
  module Resources
    class Sync < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["sync"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] product_id  product identifier 
      # @option params [String] provider_id  provider identifier 
      # @option params [String] repository_id  repository identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:provider_id/sync", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] product_id  product identifier 
      # @option params [String] provider_id  provider identifier 
      # @option params [String] repository_id  repository identifier 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:provider_id/sync", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] product_id  product identifier 
      # @option params [String] provider_id  provider identifier 
      # @option params [String] repository_id  repository identifier 
      #
      # @param [Hash] headers additional http headers
      def cancel(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:provider_id/sync", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
