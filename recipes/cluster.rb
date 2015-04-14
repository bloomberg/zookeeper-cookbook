#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
zookeeper_cluster_config node['zookeeper-cluster']['cluster_name'] do
  notifies :restart, 'service[zookeeper]'
end

service 'zookeeper' do
  supports restart: true, status: true
  action [:enable, :start]
end
