#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'forwardable'

class Chef::Provider::ZookeeperCluster < Chef::Provider::LWRPBase
  include Poise
  provides :zookeeper_cluster

  action :create do
    directory ZookeeperClusterCookbook::Config.shared_directory do
      recursive true
      mode '0644'
      owner run_user
      group run_group
    end

    file ZookeeperCluster::Config.myid_filepath do
      content new_resource.cluster_node_id
      mode '0644'
      owner run_user
      group run_group
    end

    zookeeper_cluster_config "zookeeper_cluster :join zookeeper_cluster_config[#{name}]" do
      cluster_name new_resource.cluster_name
      cluster_node_type new_resource.cluster_node_type
      config new_resource.config
    end
  end

  action :remove do
    file ZookeeperCluster::Config.myid_filepath do
      action :delete
    end
  end
end
