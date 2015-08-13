#
# Cookbook: zookeeper-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'selinux::permissive'

node.default['java']['jdk_version'] = '7'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

poise_service_user node['zookeeper-cluster']['service_user'] do
  group node['zookeeper-cluster']['service_group']
end

zookeeper_config node['zookeeper-cluster']['service_name'] do |r|
  instance_name node['fqdn']
  owner node['zookeeper-cluster']['service_user']
  group node['zookeeper-cluster']['service_group']

  node['zookeeper-cluster']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "zookeeper_service[#{name}]", :delayed
end

zookeeper_service node['zookeeper-cluster']['service_name'] do |r|
  user node['zookeeper-cluster']['service_user']
  group node['zookeeper-cluster']['service_group']
  config_path node['zookeeper-cluster']['config']['path']

  node['zookeeper-cluster']['service'].each_pair { |k, v| r.send(k, v) }
  action [:enable, :start]
end
