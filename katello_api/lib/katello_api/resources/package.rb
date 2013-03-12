module KatelloApi
  module Resources
    class Package < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["packages"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] repository_id  environment numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/repositories/:repository_id/packages", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] repository_id  environment numeric identifier 
      # @option params [String] search  search expression 
      #
      # @param [Hash] headers additional http headers
      def search(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/repositories/:repository_id/packages/search", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  package id 
      # @option params [String] repository_id  environment numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/repositories/:repository_id/packages/:id", params
        call(:"get", url, params, headers)
      end

    end
  end
end
