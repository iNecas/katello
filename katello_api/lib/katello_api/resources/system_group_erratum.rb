module KatelloApi
  module Resources
    class SystemGroupErratum < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["system_group_errata"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] system_group_id  system_group identifier 
      # @option params [String] type  filter errata by type 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:system_group_id/errata", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] errata_ids  list of errata ids to install 
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] system_group_id  system_group identifier 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:system_group_id/errata", params
        call(:"post", url, params, headers)
      end

    end
  end
end
