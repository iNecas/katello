module KatelloApi
  module Resources
    class Statu < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["status"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def memory(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/status/memory", params
        call(:"get", url, params, headers)
      end

    end
  end
end
