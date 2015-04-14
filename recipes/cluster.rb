#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'zookeeper-cluster::default'

zookeeper_cluster node['zookeeper-cluster']['cluster_name'] do
  action :create
end
