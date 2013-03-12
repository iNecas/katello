module KatelloApi
  module Resources
    class ChangesetsContent < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["changesets_content"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] product_id  the id of the product which should be added 
      #
      # @param [Hash] headers additional http headers
      def add_product(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/products", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] content_id  the id of the product to remove 
      #
      # @param [Hash] headers additional http headers
      def remove_product(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/products/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  the nvrea of the package to add 
      # @option params [String] product_id  the id of the product which contains the package 
      #
      # @param [Hash] headers additional http headers
      def add_package(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/packages", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] product_id  the id of the product which contains the package 
      #
      # @param [Hash] headers additional http headers
      def remove_package(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/packages/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] erratum_id  the id of the errata to add 
      # @option params [String] product_id  the product which contains the errata 
      #
      # @param [Hash] headers additional http headers
      def add_erratum(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/errata", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] product_id  the product which contains the errata 
      #
      # @param [Hash] headers additional http headers
      def remove_erratum(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/errata/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] repository_id  the id of the repository to add 
      #
      # @param [Hash] headers additional http headers
      def add_repo(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/repositories", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def remove_repo(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/repositories/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] template_id  the id of the template to add 
      #
      # @param [Hash] headers additional http headers
      def add_template(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/templates", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def remove_template(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/templates/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] content_view_id  the id of the content view to add 
      #
      # @param [Hash] headers additional http headers
      def add_content_view(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/content_views", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def remove_content_view(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/content_views/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] distribution_id  the id of the distribution to add 
      # @option params [String] product_id  the product which contains the distribution 
      #
      # @param [Hash] headers additional http headers
      def add_distribution(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/distributions", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def remove_distribution(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/changesets/:changeset_id/distributions/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
