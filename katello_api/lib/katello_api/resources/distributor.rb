module KatelloApi
  module Resources
    class Distributor < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["distributors"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] facts  key-value hash of distributor-specific facts 
      # @option params [String] installedProducts  list of products installed on the distributor 
      # @option params [String] location  physical of the distributor 
      # @option params [String] name  name of the distributor 
      # @option params [String] releaseVer  release of the os. the $releasever variable in repo url will be replaced with this value 
      # @option params [String, nil] serviceLevel  a service level for auto-healing process, e.g. self-support 
      # @option params [String] type  type of the distributor, it should always be ‘distributor’ 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/distributors", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] facts  key-value hash of distributor-specific facts 
      # @option params [String] installedProducts  list of products installed on the distributor 
      # @option params [String] location  physical of the distributor 
      # @option params [String] name  name of the distributor 
      # @option params [String] releaseVer  release of the os. the $releasever variable in repo url will be replaced with this value 
      # @option params [String, nil] serviceLevel  a service level for auto-healing process, e.g. self-support 
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/distributors/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  filter distributors by name 
      # @option params [String] pool_id  filter distributors by subscribed pool 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/distributors", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the distributor 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/distributors/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the distributor 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/distributors/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the distributor 
      #
      # @param [Hash] headers additional http headers
      def pools(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/distributors/:id/pools", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def report(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/distributors/report", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] distributor_name  name of the distributor 
      # @option params [String] distributor_uuid  uuid of the distributor 
      #
      # @param [Hash] headers additional http headers
      def tasks(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/distributors/tasks", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the task 
      #
      # @param [Hash] headers additional http headers
      def task_show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/distributors/tasks/:id", params
        call(:"get", url, params, headers)
      end

    end
  end
end
