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

zookeeper node['zookeeper-cluster']['version'] do
  user node['zookeeper-cluster']['user']
  mirror node['zookeeper-cluster']['url'] % { version: node['zookeeper-cluster']['version'] }
  checksum node['zookeeper-cluster']['checksum']
end
