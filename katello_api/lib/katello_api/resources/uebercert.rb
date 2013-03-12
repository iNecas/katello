module KatelloApi
  module Resources
    class Uebercert < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["uebercerts"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] regenerate  when set to ‘true’ certificate will be re-issued 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/uebercert", params
        call(:"get", url, params, headers)
      end

    end
  end
end
