#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
class Chef::Resource::ZookeeperClusterConfig < Chef::Resource::LWRPBase
  include Poise

  actions(:create, :remove)
  default_action(:create)

  attribute(:servers,
    option_collector: true)
  attribute(:config,
    option_collector: true)

  attribute(:cluster_name,
    kind_of: String,
    name_attribute: true,
    required: true,
    cannot_be: :empty)
  attribute(:cluster_node_type,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['cluster_node_type'] },
    regex: /^(participant|observer)/)
  attribute(:tick_time,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['tick_time'] })
  attribute(:client_port,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['client_port'] })
  attribute(:election_port,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['election_port'] })
  attribute(:leader_port,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['leader_port'] })
  attribute(:data_dir,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['config']['data_dir'] })
  attribute(:data_log_dir,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['config']['data_log_dir'] })
  attribute(:global_outstanding_limit,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['global_outstanding_limit'] })
  attribute(:pre_alloc_size,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['config']['pre_alloc_size'] })
  attribute(:snap_count,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['snap_count'] })
  attribute(:trace_file,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['config']['trace_file'] })
  attribute(:max_client_cnxns,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['max_client_cnxns'] })
  attribute(:client_port_address,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['config']['client_port_address'] })
  attribute(:min_session_timeout,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['min_session_timeout'] })
  attribute(:max_session_timeout,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['max_session_timeout'] })
  attribute(:election_alg,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['election_alg'] })
  attribute(:init_limit,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['init_limit'] })
  attribute(:sync_limit,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['sync_limit'] })
  attribute(:cnx_timeout,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['config']['cnx_timeout'] })
  attribute(:leader_serves,
    kind_of: [TrueClass, FalseClass, nil],
    default: lazy { node['zookeeper-cluster']['config']['leader_serves'] })
  attribute(:force_sync,
    kind_of: [TrueClass, FalseClass, nil],
    default: lazy { node['zookeeper-cluster']['config']['force_sync'] })
  attribute(:skip_a_c_l,
    kind_of: [TrueClass, FalseClass, nil],
    default: lazy { node['zookeeper-cluster']['config']['skip_a_c_l'] })

  # @see https://github.com/zk-ruby/zk-server/blob/master/lib/zk-server/config.rb#L270-300
  def to_config_file_str
    h = {
      'dataDir' => data_dir,
      'skipACL' => skip_a_c_l,
      'tickTime' => tick_time,
      'initLimit' => init_limit,
      'syncLimit' => sync_limit,
      'forceSync' => force_sync,
      'leaderServes' => leader_serves,
      'clientPort' => client_port,
      'dataLogDir' => data_log_dir,
      'preAllocSize' => pre_alloc_size,
      'maxClientCnxns' => max_client_cnxns,
      'clientPortAddress' => client_port_address,
      'minSessionTimeout' => min_session_timeout,
      'maxSessionTimeout' => max_session_timeout,
      'globalOutstandingLimit' => global_outstanding_limit
    }.merge(config).delete_if { |k,v| v.nil? }

    %w[leaderServes skipACL forceSync].each do |yorn_key|
      if h.has_key?(yorn_key)
        h[yorn_key] = h[york_key] ? 'yes' : 'no'
      end
    end

    h.sort.map { |kv| kv.join('=') }.join("\n")
  end
end
