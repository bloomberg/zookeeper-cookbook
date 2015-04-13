#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'forwardable'

class Chef::Provider::ZookeeperClusterConfig < Chef::Provider::LWRPBase
  extend Forwardable
  def_delegators :@new_resource, :cluster_name, :node_type

  use_inline_resources if defined?(use_inline_resources)
  provides :zookeeper_cluster_config

  action :create do
    directory File.dirname(ZookeeperCluster::Config.identifier_filename) do
      recursive true
      mode '0644'
      owner run_user
      group run_group
    end

    file ZookeeperCluster::Config.identifier_filename do
      content ZookeeperCluster::Config.server_id
      mode '0644'
      owner run_user
      group run_group
    end

    directory File.dirname(ZookeeperCluster::Config.filename(cluster_name)) do
      recursive true
      mode '0644'
      owner run_user
      group run_group
    end

    template ZookeeperCluster::Config.filename(cluster_name) do
      source 'zoo.cfg.erb'
      mode '0644'
      owner run_user
      group run_group
      variables(resource: @new_resource)
    end
  end

  action :remove do
    file ZookeeperCluster::Config.identifier_filename do
      action :delete
    end
  end
end
