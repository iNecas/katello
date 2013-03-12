module KatelloApi
  module Resources
    class Subscription < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["subscriptions"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] system_id  system uuid 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/subscriptions", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] pool  subscription pool uuid 
      # @option params [String] quantity  number of subscription to use 
      # @option params [String] system_id  system uuid 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/subscriptions", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  entitlement id 
      # @option params [String] system_id  system uuid 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/subscriptions/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] system_id  system uuid 
      #
      # @param [Hash] headers additional http headers
      def destroy_all(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/subscriptions", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] serial_id  subscription serial id 
      # @option params [String] system_id  system uuid 
      #
      # @param [Hash] headers additional http headers
      def destroy_by_serial(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:system_id/subscriptions/serials/:serial_id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
