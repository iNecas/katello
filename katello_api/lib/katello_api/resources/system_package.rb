module KatelloApi
  module Resources
    class SystemPackage < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["system_packages"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] groups  list of package group names 
      # @option params [String] packages  list of package names 
      # @option params [String] system_id  system identifier 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/packages", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] packages  list of packages names 
      # @option params [String] system_id  system identifier 
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/packages", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] groups  list of package group names 
      # @option params [String] packages  list of package names 
      # @option params [String] system_id  system identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/packages", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
