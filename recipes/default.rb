#
# Cookbook Name:: zookeeper-cluster
# Recipe:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
node.default['java']['jdk_version'] = '7'
include_recipe 'java::default'

user = poise_service_user node['zookeeper-cluster']['username']
libartifact_file "zookeeper-#{node['zookeeper-cluster']['version']}" do
  artifact_name 'zookeeper'
  artifact_version node['zookeeper-cluster']['version']
  remote_url node['zookeeper-cluster']['remote_url'] % { version: artifact_version }
  remote_checksum node['zookeeper-cluster']['remote_checksum']
  owner node['zookeeper-cluster']['user']
  group user.group if user.group
end
