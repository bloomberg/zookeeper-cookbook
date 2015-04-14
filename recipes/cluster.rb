#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
zookeeper_cluster_config node['zookeeper-cluster']['cluster_name'] do
  notifies :restart, "service[#{node['zookeeper-cluster']['service_name']}]"
end

poise_service node['zookeeper-cluster']['service_name'] do
  provider node['zookeeper-cluster']['service_init_type']
  command %Q(bin/zkServer.sh)
  directory ArtifactCookbook.current_directory('zookeeper')
  user node['zookeeper-cluster']['username']
  environment(
    'JAVA_HOME' => node['java']['java_home'],
    'SERVER_JVMFLAGS' => node['zookeeper-cluster']['jvm']['server_jvmflags'],
    'JMXPORT' => node['zookeeper-cluster']['jvm']['jmxport']
  )
  action [:enable, :start]
end
