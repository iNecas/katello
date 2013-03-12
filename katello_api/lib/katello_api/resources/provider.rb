module KatelloApi
  module Resources
    class Provider < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["providers"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  filter providers by name 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/providers", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  organization identifier 
      # @option params [Hash] provider 
      #   allowed keys are: 
      #   * description [String, nil]  provider description ,
      #   * name [String]  provider name ,
      #   * provider_type [String],
      #   * repository_url [String, nil]  repository url ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      # @option params [Hash] provider 
      #   allowed keys are: 
      #   * description [String, nil]  provider description ,
      #   * name [String]  provider name ,
      #   * repository_url [String, nil]  repository url ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def products(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/products", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] url  remote url to perform discovery 
      #
      # @param [Hash] headers additional http headers
      def discovery(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/discovery", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      # @option params [String] force  force import 
      # @option params [String] import  manifest file 
      #
      # @param [Hash] headers additional http headers
      def import_manifest(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/import_manifest", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def delete_manifest(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/delete_manifest", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def refresh_products(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/refresh_products", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      # @option params [String] products  array of products to import 
      #
      # @param [Hash] headers additional http headers
      def import_products(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/import_products", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  provider numeric identifier 
      # @option params [Hash] product 
      #   allowed keys are: 
      #   * description [String, nil]  product description ,
      #   * gpg_key_name [String, nil]  identifier of the gpg key ,
      #   * label [String],
      #   * name [String]  product name ,
      #
      # @param [Hash] headers additional http headers
      def product_create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/providers/:id/product_create", params
        call(:"post", url, params, headers)
      end

    end
  end
end
