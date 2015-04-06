#
# Cookbook Name:: zookeeper-cluster
# Recipe:: quorum
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'zookeeper-cluster::default'

zookeeper_config ZookeeperCluster::Config.path do
  user node['zookeeper-cluster']['user']
  config ZookeeperCluster::Config.quorum
  notifies :restart, 'service[zookeeper]'
end
