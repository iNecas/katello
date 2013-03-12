module KatelloApi
  module Resources
    class TemplatesContent < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["templates_content"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  package identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def add_package(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/packages", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  package identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def remove_package(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/packages/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  parameter identifier 
      # @option params [String] template_id  template numeric identifier 
      # @option params [String] value  parameter value 
      #
      # @param [Hash] headers additional http headers
      def add_parameter(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/parameters", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  parameter identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def remove_parameter(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/parameters/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  package group identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def add_package_group(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/package_groups", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  package group identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def remove_package_group(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/package_groups/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  package group category identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def add_package_group_category(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/package_group_categories", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  package group category identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def remove_package_group_category(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/package_group_categories/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  distribution identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def add_distribution(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/distributions", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  distribution identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def remove_distribution(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/distributions/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  repository numeric identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def add_repo(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/repositories", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  repository numeric identifier 
      # @option params [String] template_id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def remove_repo(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:template_id/repositories/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
