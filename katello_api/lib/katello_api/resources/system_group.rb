module KatelloApi
  module Resources
    class SystemGroup < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["system_groups"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  system group name to filter by 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      # @option params [Hash] system_group 
      #   allowed keys are: 
      #   * description [String, nil],
      #   * max_systems [Numeric, nil]  maximum number of systems in the group ,
      #   * name [String]  system group name ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def systems(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id/systems", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      # @option params [Hash] system_group 
      #   allowed keys are: 
      #   * system_ids [String]  array of system ids ,
      #
      # @param [Hash] headers additional http headers
      def add_systems(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id/add_systems", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      # @option params [Hash] system_group 
      #   allowed keys are: 
      #   * system_ids [String]  array of system ids ,
      #
      # @param [Hash] headers additional http headers
      def remove_systems(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id/remove_systems", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def history(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id/history", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] job_id  id of a job for filtering 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def history_show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id/history", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] organization_id  organization identifier 
      # @option params [Hash] system_group 
      #   allowed keys are: 
      #   * description [String, nil],
      #   * max_systems [Numeric, nil]  maximum number of systems in the group ,
      #   * name [String]  system group name ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  id of the system group 
      # @option params [String] organization_id  organization identifier 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/system_groups/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
