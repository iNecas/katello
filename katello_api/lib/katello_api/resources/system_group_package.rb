module KatelloApi
  module Resources
    class SystemGroupPackage < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["system_group_packages"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] groups  list of package group names 
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] packages  list of package names 
      # @option params [String] system_group_id  system_group identifier 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:system_group_id/packages", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] groups  list of package group names 
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] packages  list of package names 
      # @option params [String] system_group_id  system_group identifier 
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:system_group_id/packages", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] groups  list of package group names 
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] packages  list of package names 
      # @option params [String] system_group_id  system_group identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:system_group_id/packages", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
