#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ZookeeperConfig < Chef::Resource
  include Poise(fused: true)

  attribute(:path, kind_of: String, name_attribute: true, cannot_be: :empty)
  attribute(:user, kind_of: String, default: 'zookeeper', cannot_be: :empty)
  attribute(:group, kind_of: String, default: 'zookeeper', cannot_be: :empty)

  attribute(:servers, kind_of: Array, default: [])
  attribute(:myid, kind_of: Integer, required: true)

  attribute(:tick_time, kind_of: [NilClass, Integer], default: nil)
  attribute(:client_port, kind_of: [NilClass, Integer], default: nil)
  attribute(:election_port, kind_of: [NilClass, Integer], default: nil)
  attribute(:leader_port, kind_of: [NilClass, Integer], default: nil)
  attribute(:data_dir, kind_of: String, default: '/var/db/zookeeper')
  attribute(:data_log_dir, kind_of: [NilClass, String], default: nil)
  attribute(:global_outstanding_limit, kind_of: [NilClass, Integer], default: nil)
  attribute(:pre_alloc_size, kind_of: [NilClass, String], default: nil)
  attribute(:snap_count, kind_of: [NilClass, Integer], default: nil)
  attribute(:trace_file, kind_of: [NilClass, String], default: nil)
  attribute(:max_client_cnxns, kind_of: [NilClass, Integer], default: nil)
  attribute(:client_port_address, kind_of: [NilClass, String], default: nil)
  attribute(:min_session_timeout, kind_of: [NilClass, Integer], default: nil)
  attribute(:max_session_timeout, kind_of: [NilClass, Integer], default: nil)
  attribute(:election_alg, kind_of: [NilClass, Integer], default: nil)
  attribute(:init_limit, kind_of: [NilClass, Integer], default: nil)
  attribute(:sync_limit, kind_of: [NilClass, Integer], default: nil)
  attribute(:cnx_timeout, kind_of: [NilClass, Integer], default: nil)
  attribute(:leader_serves, equal_to: [true, false], default: false)
  attribute(:force_sync, equal_to: [true, false], default: true)
  attribute(:skip_acl, equal_to: [true, false], default: false)

  attribute(:options, option_collector: true, default: {})

  # @see https://github.com/zk-ruby/zk-server/blob/master/lib/zk-server/config.rb#L270-300
  def to_config_str
    h = options.merge({
      'dataDir' => data_dir,
      'skipACL' => skip_acl,
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
    }).delete_if { |k,v| v.nil? }

    %w{leaderServes skipACL forceSync}.each do |yorn_key|
      h[yorn_key] = h[yorn_key] ? 'yes' : 'no' if h.has_key?(yorn_key)
    end

    h.merge(h) { |k, v| "#{k}=#{v}" }.values.concat(servers).join("\n")
  end

  action(:create) do
    directory ::File.dirname(new_resource.path) do
      recursive true
      mode '0644'
    end

    file ::File.join(::File.dirname(new_resource.path), 'myid') do
      content new_resource.myid.to_s
      mode '0640'
      owner new_resource.user
      group new_resource.group
    end

    file new_resource.path do
      content new_resource.to_config_str
      mode '0644'
    end
  end

  action(:delete) do
    directory new_resource.data_dir do
      action :delete
    end

    directory new_resource.data_log_dir do
      action :delete
    end

    directory ::File.dirname(new_resource.path) do
      action :delete
    end
  end
end
