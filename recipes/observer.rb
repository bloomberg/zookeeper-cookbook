#
# Cookbook Name:: zookeeper-cluster
# Recipe:: observer
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
return if Chef::Config[:solo]

include_recipe 'zookeeper-cluster::default'

zookeeper_config ZookeeperCluster::Config.path do
  user node['zookeeper-cluster']['user']
  config ZookeeperCluster::Config.observer
  notifies :restart, 'service[zookeeper]'
end

tag node['zookeeper-cluster']['cluster_tag']
