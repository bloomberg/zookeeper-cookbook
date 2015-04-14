#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
node.default['java']['jdk_version'] = '7'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

poise_service_user node['zookeeper-cluster']['username'] do
  group node['zookeeper-cluster']['groupname']
end

artifact = libartifact_file "zookeeper-#{node['zookeeper-cluster']['version']}" do
  artifact_name 'zookeeper'
  artifact_version node['zookeeper-cluster']['version']
  remote_url node['zookeeper-cluster']['remote_url'] % { version: artifact_version }
  remote_checksum node['zookeeper-cluster']['remote_checksum']
  owner node['zookeeper-cluster']['username']
  group node['zookeeper-cluster']['groupname']
end
