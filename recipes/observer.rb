#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
node.default['zookeeper-cluster']['cluster_node_type'] = 'observer'
include_recipe 'zookeeper-cluster::cluster'
