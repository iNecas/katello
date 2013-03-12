module KatelloApi
  module Resources
    class ActivationKey < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["activation_keys"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  lists by activation key name 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        # we don't use the default path here from apipie
        url, params = fill_params_in_url "/api/environments/:environment_id/activation_keys", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/activation_keys/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] activation_key 
      #   allowed keys are: 
      #   * content_view_id [String, nil]  content view id ,
      #   * description [String, nil],
      #   * name [String]  activation key identifier (alphanum characters, space, _ and -) ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/activation_keys", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] activation_key 
      #   allowed keys are: 
      #   * content_view_id [String, nil]  content view id ,
      #   * description [String, nil],
      #   * environment_id [String, nil],
      #   * name [String]  activation key identifier (alphanum characters, space, _ and -) ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/activation_keys/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def add_pool(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/activation_keys/:id/pools", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def remove_pool(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/activation_keys/:id/pools/:poolid", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/activation_keys/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def add_system_groups(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/activation_keys/:id/system_groups", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def remove_system_groups(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/activation_keys/:id/system_groups", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
