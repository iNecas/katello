module KatelloApi
  module Resources
    class Template < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["templates"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] environment_id  environment numeric identifier 
      # @option params [String] name  system template identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/templates", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  system template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] environment_id  environment numeric identifier 
      # @option params [Hash] template 
      #   allowed keys are: 
      #   * description [String, nil]  template description ,
      #   * name [String]  new template name ,
      #   * parent_id [String, nil]  parent template numeric identifier ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  template numeric identifier 
      # @option params [Hash] template 
      #   allowed keys are: 
      #   * description [String, nil]  template description ,
      #   * name [String]  new template name ,
      #   * parent_id [String, nil]  parent template numeric identifier ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] environment_id  environment numeric identifier 
      # @option params [Hash] template 
      #   allowed keys are: 
      #   * description [String, nil]  template description ,
      #   * name [String]  new template name ,
      #   * parent_id [String, nil]  parent template numeric identifier ,
      # @option params [String] template_file  template file to import 
      #
      # @param [Hash] headers additional http headers
      def import(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/import", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def validate(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:id/validate", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  template numeric identifier 
      #
      # @param [Hash] headers additional http headers
      def export(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/templates/:id/export", params
        call(:"get", url, params, headers)
      end

    end
  end
end
