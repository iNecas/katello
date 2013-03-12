module KatelloApi
  module Resources
    class RoleLdapGroup < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["role_ldap_groups"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  name of the ldap group 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/ldap_groups", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  ldap group (name) 
      # @option params [String] role_id  role identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/ldap_groups/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] role_id  role identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/ldap_groups", params
        call(:"get", url, params, headers)
      end

    end
  end
end
