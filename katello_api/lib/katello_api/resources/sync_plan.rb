module KatelloApi
  module Resources
    class SyncPlan < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["sync_plans"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] interval  filter by interval 
      # @option params [String] name  filter by name 
      # @option params [String] organization_id  oranization identifier 
      # @option params [String] sync_date  filter by sync date 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/sync_plans", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  sync plan numeric identifier 
      # @option params [String] organization_id  oranization identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/sync_plans/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  oranization identifier 
      # @option params [Hash] sync_plan 
      #   allowed keys are: 
      #   * description [String, nil]  sync plan description ,
      #   * interval [String, nil]  how often synchronization should run ,
      #   * name [String]  sync plan name ,
      #   * sync_date [String, nil]  start datetime of synchronization ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/sync_plans", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  sync plan numeric identifier 
      # @option params [String] organization_id  oranization identifier 
      # @option params [Hash] sync_plan 
      #   allowed keys are: 
      #   * description [String, nil]  sync plan description ,
      #   * interval [String, nil]  how often synchronization should run ,
      #   * name [String]  sync plan name ,
      #   * sync_date [String, nil]  start datetime of synchronization ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/sync_plans/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  sync plan numeric identifier 
      # @option params [String] organization_id  oranization identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/sync_plans/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
