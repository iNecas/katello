module KatelloApi
  module Resources
    class Permission < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["permissions"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] all_tags  filter by all_flags flag 
      # @option params [String] all_verbs  filter by all_verbs flag 
      # @option params [String] description  filter by description 
      # @option params [String] name  filter by name 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/permissions", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/permissions/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] all_tags  true if the permission should use all tags 
      # @option params [String, nil] description 
      # @option params [String] name 
      # @option params [String] organization_id 
      # @option params [String] tags  array of tag ids 
      # @option params [String] type  name of a resource or ‘all’ 
      # @option params [String] verbs  array of permission verbs 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/permissions", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/roles/:role_id/permissions/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
