#
# Cookbook: zookeeper-cluster
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
include_recipe 'selinux::disabled'

node.default['java']['jdk_version'] = '8'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

poise_service_user node['zookeeper-cluster']['service_user'] do
  group node['zookeeper-cluster']['service_group']
end

config = zookeeper_config node['zookeeper-cluster']['service_name'] do |r|
  instance_name node['fqdn']
  owner node['zookeeper-cluster']['service_user']
  group node['zookeeper-cluster']['service_group']

  node['zookeeper-cluster']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "zookeeper_service[#{name}]", :delayed
end

zookeeper_service node['zookeeper-cluster']['service_name'] do |r|
  user node['zookeeper-cluster']['service_user']
  group node['zookeeper-cluster']['service_group']
  config_path config.path

  node['zookeeper-cluster']['service'].each_pair { |k, v| r.send(k, v) }
end

config_directory = node.default['zookeeper-cluster']['service']['environment']['ZOOCFGDIR']

template "#{config_directory}/log4j.properties" do
	source 'log4j_properties.erb'
	owner 'zookeeper'
	group 'zookeeper'
	mode '0644'
	
	variables({
		rootLogLevel: 'INFO',
		consoleThreshold: 'INFO',
		maxFileSize: '10MB',
		maxNumFiles: '500'
	})
        
        notifies :restart, "zookeeper_service[#{node['zookeeper-cluster']['service_name']}]", :delayed
end
