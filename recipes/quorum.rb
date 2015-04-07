#
# Cookbook Name:: zookeeper-cluster
# Recipe:: quorum
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
return if Chef::Config[:solo]
include_recipe 'zookeeper-cluster::default'
tag node['zookeeper-cluster']['cluster_name']
