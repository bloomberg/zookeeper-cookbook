#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'forwardable'

class Chef::Resource::ZookeeperClusterConfig < Chef::Resource::LWRPBase
  self.resource_name = :zookeeper_cluster_config
  actions :create, :remove
  default_action :create

  attribute :cluster_name, kind_of: String, name_attribute: true, required: true
  attribute :node_type, kind_of: String, required: true, default: 'participant', regex: /^(participant|observer)$/
  attribute :tick_time, kind_of: Integer, default: 2_000
  attribute :client_port, kind_of: Integer, default: 2181
  attribute :election_port, kind_of: Integer, default: 2888
  attribute :leader_port, kind_of: Integer, default: 3888
  attribute :data_log_dir, kind_of: String
  attribute :global_outstanding_limit, kind_of: Integer, default: 1_000
  attribute :pre_alloc_size, kind_of: String
  attribute :snap_count, kind_of: Integer
  attribute :trace_file, kind_of: String
  attribute :max_client_cnxns, kind_of: Integer
  attribute :client_port_address, kind_of: String
  attribute :min_session_timeout, kind_of: Integer
  attribute :max_session_timeout, kind_of: Integer
  attribute :election_alg, kind_of: Integer
  attribute :init_limit, kind_of: Integer
  attribute :sync_limit, kind_of: Integer
  attribute :leader_serves, kind_of: [TrueClass, FalseClass]
  attribute :cnx_timeout, kind_of: Integer
  attribute :force_sync, kind_of: [TrueClass, FalseClass]
  attribute :skip_a_c_l, kind_of: [TrueClass, FalseClass]
end

class Chef::Provider::ZookeeperClusterConfig < Chef::Provider::LWRPBase
  extend Forwardable
  def_delegators :@new_resource, :cluster_name, :node_type

  use_inline_resources if defined?(use_inline_resources)
  provides :zookeeper_cluster_config

  action :create do
  end

  action :remove do
  end
end
