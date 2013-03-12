module KatelloApi
  module Resources
    class RepositorySet < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["repository_sets"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id or name of the repository set to enable 
      # @option params [String] organization_id  id of an organization the repository will be contained in 
      # @option params [String] product_id  id of a product the repository will be contained in 
      #
      # @param [Hash] headers additional http headers
      def enable(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/product/:product_id/repository_set/:id/enable", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the repository set to disable 
      # @option params [String] organization_id  id of an organization the repository will be contained in 
      # @option params [String] product_id  id of a product the repository will be contained in 
      #
      # @param [Hash] headers additional http headers
      def disable(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/product/:product_id/repository_set/:id/disable", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  id of an 
      # @option params [String] product_id  id of a product to list repository sets in 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/product/:product_id/repository_set", params
        call(:"get", url, params, headers)
      end

    end
  end
end
