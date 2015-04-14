#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'forwardable'

class Chef::Provider::ZookeeperClusterConfig < Chef::Provider::LWRPBase
  include Poise
  extend Forwardable
  def_delegators :@new_resource, :cluster_name, :cluster_node_type, :cluster_node_id

  provides :zookeeper_cluster_config

  action :create do
    directory ZookeeperClusterCookbook::Config.config_directory do
      recursive true
      mode '0644'
      owner run_user
      group run_group
    end

    file ZookeeperCluster::Config.myid_filepath do
      content cluster_node_id
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
    file ZookeeperCluster::Config.myid_filepath do
      action :delete
    end
  end
end
