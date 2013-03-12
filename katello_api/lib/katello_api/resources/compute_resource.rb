module KatelloApi
  module Resources
    class ComputeResource < KatelloApi::Base
      def self.doc
        @doc ||= KatelloApi.doc['resources']["compute_resources"]
      end

      # @param [Hash] params a hash of params to be passed to the service
      #
      # @param [Hash] headers additional http headers
      def index(params = { }, headers = { })
        check_params params, :allowed => false, :method => __method__
        url, params = fill_params_in_url "/api/compute_resources", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  compute resource name 
      #
      # @param [Hash] headers additional http headers
      def show(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/compute_resources/:id", params
        call(:"get", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [Hash] compute_resource  compute resource info 
      #   allowed keys are: 
      #   * description [String, nil],
      #   * name [String],
      #   * password [String, nil]  password for ovirt, ec2, vmware, openstack. secret key for ec2 ,
      #   * provider [String]  providers include libvirt, ovirt, ec2, vmware, openstack, rackspace ,
      #   * region [String, nil]  for ec2 only ,
      #   * server [String, nil]  for vmware ,
      #   * tenant [String, nil]  for openstack only ,
      #   * url [String]  url for libvirt, ovirt, and openstack ,
      #   * user [String, nil]  username for ovirt, ec2, vmware, openstack. access key for ec2. ,
      #   * uuid [String, nil]  for ovirt, vmware datacenter ,
      #
      # @param [Hash] headers additional http headers
      def create(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/compute_resources", params
        call(:"post", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  compute resource name 
      # @option params [Hash] compute_resource  compute resource info 
      #   allowed keys are: 
      #   * description [String, nil],
      #   * name [String],
      #   * password [String, nil]  password for ovirt, ec2, vmware, openstack. secret key for ec2 ,
      #   * provider [String]  providers include libvirt, ovirt, ec2, vmware, openstack, rackspace ,
      #   * region [String, nil]  for ec2 only ,
      #   * server [String, nil]  for vmware ,
      #   * tenant [String, nil]  for openstack only ,
      #   * url [String]  url for libvirt, ovirt, and openstack ,
      #   * user [String, nil]  username for ovirt, ec2, vmware, openstack. access key for ec2. ,
      #   * uuid [String, nil]  for ovirt, vmware datacenter ,
      #
      # @param [Hash] headers additional http headers
      def update(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/compute_resources/:id", params
        call(:"put", url, params, headers)
      end

      # @param [Hash] params a hash of params to be passed to the service
      # @option params [String] id  compute resource name 
      #
      # @param [Hash] headers additional http headers
      def destroy(params = { }, headers = { })
        check_params params, :allowed => true, :method => __method__
        url, params = fill_params_in_url "/api/compute_resources/:id", params
        call(:"delete", url, params, headers)
      end

    end
  end
end
