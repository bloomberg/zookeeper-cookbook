#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
config = zookeeper_cluster_config node['zookeeper-cluster']['cluster']['name'] do
  node_type node['zookeeper-cluster']['cluster']['node_type']
  tick_time node['zookeeper-cluster']['cluster']['tick_type']
  client_port node['zookeeper-cluster']['cluster']['client_port']
  election_port node['zookeeper-cluster']['cluster']['election_port']
  leader_port node['zookeeper-cluster']['cluster']['leader_port']
  data_log_dir node['zookeeper-cluster']['cluster']['data_log_dir']
  global_outstanding_limit node['zookeeper-cluster']['cluster']['global_outstanding_limit']
  pre_alloc_size node['zookeeper-cluster']['cluster']['pre_alloc_size']
  snap_count node['zookeeper-cluster']['cluster']['snap_count']
  trace_file node['zookeeper-cluster']['cluster']['trace_file']
  max_client_cnxns node['zookeeper-cluster']['cluster']['max_client_cnxns']
  client_address node['zookeeper-cluster']['cluster']['client_address']
  min_session_timeout node['zookeeper-cluster']['cluster']['min_session_timeout']
  max_session_timeout node['zookeeper-cluster']['cluster']['max_session_timeout']
  election_alg node['zookeeper-cluster']['cluster']['election_alg']
  init_limit node['zookeeper-cluster']['cluster']['init_limit']
  sync_limit node['zookeeper-cluster']['cluster']['sync_limit']
  leader_serves node['zookeeper-cluster']['cluster']['leader_serves']
  cnx_timeout node['zookeeper-cluster']['cluster']['cnx_timeout']
  force_sync node['zookeeper-cluster']['cluster']['force_sync']
  skip_a_c_l node['zookeeper-cluster']['cluster']['skip_a_c_l']
end

poise_service 'zookeeper' do
  provider node['zookeeper-cluster']['init_type']
  command ZookeeperCluster.command
  user node['zookeeper-cluster']['username']
  directory ZookeeperCluster.release_directory
  environment('JAVA_HOME' => node['java']['java_home'])
end
