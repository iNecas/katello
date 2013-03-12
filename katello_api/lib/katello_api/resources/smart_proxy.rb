module KatelloApi
  module Resources
    class SmartProxy < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["smart_proxies"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] order  sort results 
      # @option params [String] search  filter results 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/smart_proxies", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  domain name (no slashes) 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/smart_proxies/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] smart_proxy 
      #   allowed keys are: 
      #   * name [String]  the smart proxy name ,
      #   * url [String]  the smart proxy url starting with ‘http://’ or ‘https://’ ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/smart_proxies", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] smart_proxy 
      #   allowed keys are: 
      #   * name [String]  the smart proxy name ,
      #   * url [String]  the smart proxy url starting with ‘http://’ or ‘https://’ ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/smart_proxies/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  domain name (no slashes) 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/smart_proxies/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
