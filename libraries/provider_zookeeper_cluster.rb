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
    directory ZookeeperClusterCookbook.shared_directory do
      recursive true
      mode '0644'
      owner run_user
      group run_group
    end

    file ZookeeperClusterCookbook.myid_filepath do
      content new_resource.cluster_node_id
      mode '0644'
      user ZookeeperClusterCookbook.run_user
      group ZookeeperClusterCookbook.run_group
    end

    zookeeper_cluster_config new_resource.cluster_name do
      cluster_node_type new_resource.cluster_node_type
      config new_resource.config
      action :create
    end

    poise_service ZookeeperClusterCookbook.service_name do
      command 'bin/zkServer.sh'
      provider ZookeeperClusterCookbook.service_init_type
      directory ZookeeperClusterCookbook.run_directory
      user ZookeeperClusterCookbook.run_user
      group ZookeeperClusterCookbook.run_group
      environment ZookeeperClusterCookbook.run_environment
      action [:enable, :start]
    end
  end

  action :remove do
    poise_service ZookeeperClusterCookbook.service_name do
      command 'bin/zkServer.sh'
      provider ZookeeperClusterCookbook.service_init_type
      directory ZookeeperClusterCookbook.run_directory
      user ZookeeperClusterCookbook.run_user
      group ZookeeperClusterCookbook.run_group
      environment ZookeeperClusterCookbook.run_environment
      action [:disable, :stop]
    end

    zookeeper_cluster_config new_resource.cluster_name do
      cluster_node_type new_resource.cluster_node_type
      config new_resource.config
      action :remove
    end

    file ZookeeperClusterCookbook.myid_filepath do
      action :delete
    end
  end
end
