module KatelloApi
  module Resources
    class ConfigTemplate < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["config_templates"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] order  sort results 
      # @option params [String] search  filter results 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/config_templates", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/config_templates/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] config_template 
      #   allowed keys are: 
      #   * audit_comment [String, nil],
      #   * name [String]  template name ,
      #   * snippet [String, nil],
      #   * template [String],
      #   * template_combinations_attributes [String, nil]  array of template combinations (hostgroup_id, environment_id) ,
      #   * template_kind_id [String, nil]  not relevant for snippet ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/config_templates", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] config_template 
      #   allowed keys are: 
      #   * audit_comment [String, nil],
      #   * name [String]  template name ,
      #   * snippet [String, nil],
      #   * template [String],
      #   * template_combinations_attributes [String, nil]  array of template combinations (hostgroup_id, environment_id) ,
      #   * template_kind_id [String, nil]  not relevant for snippet ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/config_templates/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/config_templates/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] version  template version 
      #
      # @param [Hash] headers additional http headers
      def revision(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/config_templates/revision", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def build_pxe_default(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/config_templates/build_pxe_default", params
        call(:"get", url, params, headers)
      end

    end
  end
end
