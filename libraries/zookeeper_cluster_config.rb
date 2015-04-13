#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
module ZookeeperCluster
  module Config
    def filename(cluster_name)
      File.join(ArtifactCookbook.shared_path('zookeeper'), 'conf', "#{cluster_name}.cfg")
    end

    def identifier_filename
      File.join(ArtifactCookbook.shared_path('zookeeper'), 'myid')
    end

    def server_id
      node['zookeeper-cluster']['config']['server_id']
    end

    def connection_timeout
      node['zookeeper-cluster']['config']['connection_timeout']
    end

    def tick_time
      node['zookeeper-cluster']['config']['tick_time']
    end

    def client_address
      node['zookeeper-cluster']['config']['client_address']
    end

    def min_session_timeout
      node['zookeeper-cluster']['config']['min_session_timeout']
    end

    def max_session_timeout
      node['zookeeper-cluster']['config']['max_session_timeout']
    end

    def max_client_connections
      node['zookeeper-cluster']['config']['max_client_connections']
    end

    def trace_file
      node['zookeeper-cluster']['config']['trace_file']
    end

    def snap_count
      node['zookeeper-cluster']['config']['snap_count']
    end

    def client_port
      node['zookeeper-cluster']['config']['client_port']
    end

    def election_port
      node['zookeeper-cluster']['config']['election_port']
    end

    def leader_port
      node['zookeeper-cluster']['config']['leader_port']
    end

    def data_directory
      node['zookeeper-cluster']['config']['data_directory']
    end

    def data_log_directory
      node['zookeeper-cluster']['config']['data_log_directory']
    end

    def global_outstanding_limit
      node['zookeeper-cluster']['config']['global_outstanding_limit']
    end

    def pre_alloc_size
      node['zookeeper-cluster']['config']['pre_alloc_size']
    end

    def election_algorithm
      node['zookeeper-cluster']['config']['election_algorithm']
    end

    def sync_limit
      node['zookeeper-cluster']['config']['sync_limit']
    end

    def init_limit
      node['zookeeper-cluster']['config']['init_limit']
    end

    def leader_serves?
      return false unless node['zookeeper-cluster']['config']['leader_serves']
      node['zookeeper-cluster']['config']['leader_serves']
    end

    def force_sync?
      return false unless node['zookeeper-cluster']['config']['force_sync']
      node['zookeeper-cluster']['config']['force_sync']
    end

    def skip_acl?
      return false unless node['zookeeper-cluster']['config']['skip_acl']
      node['zookeeper-cluster']['config']['skip_acl']
    end
  end
end
