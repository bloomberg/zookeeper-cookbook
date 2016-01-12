config_dir = node['zookeeper-cluster']['service']['environment']['ZOOCFGDIR']
prefix = node['zookeeper-cluster']['service']['environment']['

template "#{config_dir}/#{prefix}log4j.properties" do
  source 'generic_properties.erb'
  mode '0644'
  owner 'zookeeper'
  group 'zookeeper'
  action :create
  variables properties: node['zookeeper']['log4j']
  only_if { node['zookeeper'].key?('log4j') && !node['zookeeper']['log4j'].empty? }
  notifies :restart, "zookeeper_service[#{node['zookeeper-cluster']['service_name']}]", :delayed
end
