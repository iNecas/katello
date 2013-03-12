module KatelloApi
  module Resources
    class HardwareModel < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["hardware_models"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/hardware_models", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  hardware model name 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/hardware_models/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] hardware_model  hardware model info 
      #   allowed keys are: 
      #   * hardware_model [String, nil],
      #   * info [String, nil],
      #   * name [String],
      #   * vendor_class [String, nil],
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/hardware_models", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  hardware model name 
      # @option params [Hash] hardware_model  hardware model info 
      #   allowed keys are: 
      #   * hardware_model [String, nil],
      #   * info [String, nil],
      #   * name [String],
      #   * vendor_class [String, nil],
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/hardware_models/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  hardware model name 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/hardware_models/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
