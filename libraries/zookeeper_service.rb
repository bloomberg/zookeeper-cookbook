#
# Cookbook: zookeeper-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

# Resource for managing the Consul service on an instance.
# @since 1.0.0
class Chef::Resource::ZookeeperService < Chef::Resource
  provides(:zookeeper_service)
  include PoiseService::ServiceMixin

  # @!attribute service_name
  # @return [String]
  attribute(:service_name, kind_of: String, name_attribute: true)

  # @!attribute version
  # @return [String]
  attribute(:version, kind_of: String, required: true)

  # @!attribute install_method
  # @return [Symbol]
  attribute(:install_method, default: 'binary', equal_to: %w{binary package})

  # @!attribute install_path
  # @return [String]
  attribute(:install_path, kind_of: String, default: '/srv')

  # @!attribute user
  # @return [String]
  attribute(:user, kind_of: String, default: 'zookeeper')

  # @!attribute group
  # @return [String]
  attribute(:group, kind_of: String, default: 'zookeeper')

  # @!attribute environment
  # @return [String]
  attribute(:environment, kind_of: Hash, default: lazy { default_environment })

  # @!attribute package_name
  # @return [String]
  attribute(:package_name, kind_of: String, default: 'zookeeper')

  # @!attribute binary_url
  # @return [String]
  attribute(:binary_url, kind_of: String)

  # @!attribute binary_url
  # @return [String]
  attribute(:binary_checksum, kind_of: String)

  # @!attribute data_dir
  # @return [String]
  attribute(:data_dir, kind_of: String, default: '/var/db/zookeeper')

  # @!attribute data_log_dir
  # @return [String]
  attribute(:data_log_dir, kind_of: [NilClass, String], default: nil)

  # @!attribute config_filename
  # @return [String]
  attribute(:config_path, kind_of: String, default: '/etc/zookeeper/zookeeper.cfg')

  def default_environment
    { PATH: '/usr/local/bin:/usr/bin:/bin' }
  end

  def command
    "bin/zkServer.sh start-foreground #{config_path}"
  end
end

# Provider for managing the Consul service on an instance.
# @since 1.0.0
class Chef::Provider::ZookeeperService < Chef::Provider
  provides(:zookeeper_service)
  include PoiseService::ServiceMixin

  def action_enable
    notifying_block do
      package new_resource.package_name do
        version new_resource.version unless new_resource.version.nil?
        only_if { new_resource.install_method == 'package' }
      end

      libartifact_file "zookeeper-#{new_resource.version}" do
        artifact_name 'zookeeper'
        artifact_version new_resource.version
        install_path new_resource.install_path
        remote_url new_resource.binary_url % { version: new_resource.version }
        remote_checksum new_resource.binary_checksum
        only_if { new_resource.install_method 'binary' }
      end

      directory new_resource.data_dir do
        recursive true
        mode '0640'
        owner new_resource.user
        group new_resource.group
      end
    end
    super
  end

  def action_disable
    notifying_block do
      directory new_resource.data_dir do
        action :delete
      end
    end
    super
  end

  def service_options(service)
    service.command(new_resource.command)
    service.directory(new_resource.data_dir)
    service.user(new_resource.user)
    service.environment(new_resource.environment)
    service.restart_on_update(true)
  end
end
