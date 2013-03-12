module KatelloApi
  module Resources
    class Ping < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["ping"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/ping", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def status(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/status", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def version(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/version", params
        call(:"get", url, params, headers)
      end

    end
  end
end
