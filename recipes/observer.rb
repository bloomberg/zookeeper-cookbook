#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'zookeeper-cluster::default'

node.default['zookeeper-cluster']['node_type'] = 'observer'
include_recipe 'zookeeper-cluster::cluster_config'
