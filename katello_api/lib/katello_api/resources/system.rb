module KatelloApi
  module Resources
    class System < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["systems"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] content_view_id 
      # @option params [String] environment_id 
      # @option params [Hash, nil] facts  key-value hash of system-specific facts 
      # @option params [String, nil] installedProducts  list of products installed on the system 
      # @option params [String] location  physical of the system 
      # @option params [String] name  name of the system 
      # @option params [String, nil] serviceLevel  a service level for auto-healing process, e.g. self-support 
      # @option params [String] type  type of the system, it should always be ‘system’ 
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/consumers", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def hypervisors_update(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/hypervisors", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] activation_keys 
      # @option params [String] content_view_id 
      # @option params [String] environment_id 
      # @option params [Hash, nil] facts  key-value hash of system-specific facts 
      # @option params [String, nil] installedProducts  list of products installed on the system 
      # @option params [String] location  physical of the system 
      # @option params [String] name  name of the system 
      # @option params [String, nil] serviceLevel  a service level for auto-healing process, e.g. self-support 
      # @option params [String] type  type of the system, it should always be ‘system’ 
      #
      # @param [Hash] headers additional http headers
      def activate(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/consumers", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the consumer 
      #
      # @param [Hash] headers additional http headers
      def regenerate_identity_certificates(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/consumers/:id", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] content_view_id 
      # @option params [String] environment_id 
      # @option params [Hash, nil] facts  key-value hash of system-specific facts 
      # @option params [String, nil] installedProducts  list of products installed on the system 
      # @option params [String] location  physical of the system 
      # @option params [String] name  name of the system 
      # @option params [String, nil] serviceLevel  a service level for auto-healing process, e.g. self-support 
      # @option params [String] type  type of the system, it should always be ‘system’ 
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/consumers/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] name  filter systems by name 
      # @option params [String] pool_id  filter systems by subscribed pool 
      # @option params [String] search  filter systems by advanced search query 
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/consumers", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/consumers/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/consumers/:id", params
        call(:"delete", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def pools(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/pools", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def releases(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/releases", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def package_profile(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/packages", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def errata(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/errata", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def upload_package_profile(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/consumers/:id/packages", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def report(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/environments/:environment_id/systems/report", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] system_name  name of the system 
      # @option params [String] system_uuid  uuid of the system 
      #
      # @param [Hash] headers additional http headers
      def tasks(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/organizations/:organization_id/systems/tasks", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  uuid of the task 
      #
      # @param [Hash] headers additional http headers
      def task_show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/tasks/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def enabled_repos(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/enabled_repos", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] system 
      #   allowed keys are: 
      #   * system_group_ids [String]  list of group ids to add the system to ,
      #
      # @param [Hash] headers additional http headers
      def add_system_groups(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/system_groups", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] system 
      #   allowed keys are: 
      #   * system_group_ids [String]  list of group ids to add the system to ,
      #
      # @param [Hash] headers additional http headers
      def remove_system_groups(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/systems/:id/system_groups", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
