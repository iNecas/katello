module KatelloApi
  module Resources
    class Environment < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["environments"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] library  set true if you want to see only library environment 
      # @option params [String] name  filter only environments with this identifier 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/environments", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] library  set true if you want to see only library environment 
      # @option params [String] name  filter only environments with this identifier 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def rhsm_index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/owners/:organization_id/environments", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  environment identifier 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] environment 
      #   allowed keys are: 
      #   * description [String, nil],
      #   * name [String]  name of the environment (identifier) ,
      #   * prior [String]  identifier of an environment that is prior the new environment in the chain, it has to be either library or an environment at the end of the chain ,
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/environments", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] environment 
      #   allowed keys are: 
      #   * description [String, nil],
      #   * name [String]  name of the environment (identifier) ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  environment identifier 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  environment identifier 
      # @option params [String] include_disabled  set to true if you want to see also disabled repositories 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def repositories(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/environments/:id/repositories", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  environment identifier 
      #
      # @param [Hash] headers additional http headers
      def releases(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:id/releases", params
        call(:"get", url, params, headers)
      end

    end
  end
end
