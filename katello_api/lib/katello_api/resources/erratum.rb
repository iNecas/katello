module KatelloApi
  module Resources
    class Erratum < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["errata"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] environment_id  id of environment containing the errata. 
      # @option params [String] product_id  the product which contains the errata. 
      # @option params [String] repoid  id of repository containing the errata. 
      # @option params [String] severity  severity of errata. usually one of: critical, important, moderate, low. case insensitive. 
      # @option params [String] type  type of errata. usually one of: security, bugfix, enhancement. case insensitive. 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/errata", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/repositories/:repository_id/errata/:id", params
        call(:"get", url, params, headers)
      end

    end
  end
end
