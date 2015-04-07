#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
zookeeper_cluster_config ZookeeperCluster::Config.cluster_name do
  node_type ZookeeperCluster::Config.node_type
  tick_time ZookeeperCluster::Config.tick_type
  client_port ZookeeperCluster::Config.client_port
  election_port ZookeeperCluster::Config.election_port
  leader_port ZookeeperCluster::Config.leader_port
  data_log_dir ZookeeperCluster::Config.data_log_directory
  global_outstanding_limit ZookeeperCluster::Config.global_outstanding_limit
  pre_alloc_size ZookeeperCluster::Config.pre_alloc_size
  snap_count ZookeeperCluster::Config.snap_count
  trace_file ZookeeperCluster::Config.trace_file
  max_client_cnxns ZookeeperCluster::Config.max_client_connections
  client_address ZookeeperCluster::Config.client_address
  min_session_timeout ZookeeperCluster::Config.min_session_timeout
  max_session_timeout ZookeeperCluster::Config.max_session_timeout
  election_alg ZookeeperCluster::Config.election_algorithm
  init_limit ZookeeperCluster::Config.init_limit
  sync_limit ZookeeperCluster::Config.sync_limit
  cnx_timeout ZookeeperCluster::Config.connection_timeout
  leader_serves ZookeeperCluster::Config.leader_serves?
  force_sync ZookeeperCluster::Config.force_sync?
  skip_a_c_l ZookeeperCluster::Config.skip_acl?
end

poise_service 'zookeeper' do
  provider node['zookeeper-cluster']['init_type']
  command "bin/zkServer.sh -f #{ZookeeperCluster::Config.filename}"
  user node['zookeeper-cluster']['username']
  directory ArtifactCookbook.current_symlink(name)
  environment('JAVA_HOME' => node['java']['java_home'])
end
