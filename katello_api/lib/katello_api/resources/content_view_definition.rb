module KatelloApi
  module Resources
    class ContentViewDefinition < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["content_view_definitions"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  content view id 
      # @option params [String] label  content view label 
      # @option params [String] name  content view name 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/content_view_definitions", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] content_view_definition 
      #   allowed keys are: 
      #   * description [String, nil]  definition description ,
      #   * label [String]  content view identifier ,
      #   * name [String]  content view definition name ,
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_view_definitions", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  definition identifer 
      # @option params [Hash] content_view_definition 
      #   allowed keys are: 
      #   * description [String, nil]  definition description ,
      #   * name [String]  content view definition name ,
      # @option params [String] org  organization name 
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:org/content_view_definitions/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  definition identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_view_definitions/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  definition identifier 
      # @option params [String] description  description for the new content view 
      # @option params [String] label  label for the new content view 
      # @option params [String] name  name for the new content view 
      #
      # @param [Hash] headers additional http headers
      def publish(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:name/content_view_definitions/:id/publish", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  definition identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_view_definitions/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  definition identifier 
      #
      # @param [Hash] headers additional http headers
      def content_views(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_view_definitions/:id/content_views", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  definition identifier 
      # @option params [String] views  updated list of view ids 
      #
      # @param [Hash] headers additional http headers
      def update_content_views(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/content_view_definitions/:id/content_views", params
        call(:"put", url, params, headers)
      end

    end
  end
end
