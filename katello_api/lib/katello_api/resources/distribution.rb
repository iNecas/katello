module KatelloApi
  module Resources
    class Distribution < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["distributions"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/repositories/:repository_id/distributions", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] repository_id  repository numeric id 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/repositories/:repository_id/distributions/:id", params
        call(:"get", url, params, headers)
      end

    end
  end
end
