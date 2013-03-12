module KatelloApi
  module Resources
    class Crl < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["crls"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/crls", params
        call(:"get", url, params, headers)
      end

    end
  end
end
