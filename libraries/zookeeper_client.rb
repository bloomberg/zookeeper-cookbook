#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ZookeeperClient < Chef::Resource
  include Poise(fused: true)
  provides(:zookeeper_client)
  actions(:create, :delete)

  attribute(:install_path,
            kind_of: String,
            name_attribute: true,
            required: true)

  attribute(:install_method,
            kind_of: String,
            default: 'binary',
            cannot_be: :empty)
  attribute(:binary_url,
            kind_of: String,
            cannot_be: :empty)
  attribute(:binary_version,
            kind_of: String,
            cannot_be: :empty)
  attribute(:source_url,
            kind_of: String,
            cannot_be: :empty)
  attribute(:source_version,
            kind_of: String,
            cannot_be: :empty)

  action(:create) do
    libartifact_file "zookeeper-#{new_resource.binary_version}" do
      artifact_name 'zookeeper'
      artifact_version new_resource.binary_version
      remote_url new_resource.binary_url
      remote_checksum new_resource.binary_checksum
      only_if { new_resource.install_method == 'binary' }
    end

    if new_resource.install_method == 'source'
    end
  end

  action(:delete) do
    libartifact_file "zookeeper-#{new_resource.binary_version}" do
      artifact_name 'zookeeper'
      artifact_version new_resource.binary_version
      action :delete
      only_if { new_resource.install_method == 'binary' }
    end

    if new_resource.install_method == 'source'
      directory new_resource.path do
        action :delete
      end

      directory Dir.dirname(new_resource.filename) do
        action :delete
      end

      link ::File.join(new_resource.path, 'consul') do
        to new_resource.filename
        action :delete
      end
    end
  end
end
