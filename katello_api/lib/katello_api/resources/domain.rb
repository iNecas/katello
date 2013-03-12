module KatelloApi
  module Resources
    class Domain < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["domains"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] order  sort results 
      # @option params [String] search  filter results 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/domains", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  domain name (no slashes) 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/domains/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] domain 
      #   allowed keys are: 
      #   * dns_id [String, nil]  dns proxy to use within this domain ,
      #   * domain_parameters_attributes [String, nil]  array of parameters (name, value) ,
      #   * fullname [String, nil]  full name describing the domain ,
      #   * name [String]  the full dns domain name ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/domains", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] domain 
      #   allowed keys are: 
      #   * dns_id [String, nil]  dns proxy to use within this domain ,
      #   * domain_parameters_attributes [String, nil]  array of parameters (name, value) ,
      #   * fullname [String, nil]  full name describing the domain ,
      #   * name [String]  the full dns domain name ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/domains/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  domain name (no slashes) 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/domains/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
