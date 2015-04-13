#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
node.default['java']['jdk_version'] = '7'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

group node['zookeeper-cluster']['groupname'] do
  system true
end

user node['zookeeper-cluster']['username'] do
  system true
  group node['zookepeer-cluster']['groupname']
end

libartifact_file "zookeeper-#{node['zookeeper-cluster']['version']}" do
  artifact_name 'zookeeper'
  artifact_version node['zookeeper-cluster']['version']
  remote_url node['zookeeper-cluster']['remote_url'] % { version: artifact_version }
  remote_checksum node['zookeeper-cluster']['remote_checksum']
  owner node['zookeeper-cluster']['username']
  group node['zookeeper-cluster']['groupname']
end

template File.join(ZookeeperCluster::Config.config_directory, 'zookeeper-env.sh') do
  source 'zookeeper-env.sh.erb'
  mode '0644'
  variables(java_home: node['java']['java_home'])
end

template '/etc/init.d/zookeeper' do
  source 'zookeeper-sysvinit.sh.erb'
  mode '0755'
  variables()
end
