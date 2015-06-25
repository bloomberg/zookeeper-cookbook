#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ZookeeperConfig < Chef::Resource
  include Poise(fused: true)
  provides(:zookeeper_config)

  attribute(:path, kind_of: String, name_attribute: true, cannot_be: :empty)
  attribute(:user, kind_of: String, default: 'zookeeper', cannot_be: :empty)
  attribute(:group, kind_of: String, default: 'zookeeper', cannot_be: :empty)

  attribute(:instance_name, kind_of: String, required: true)
  attribute(:data_dir, kind_of: String, default: '/var/lib/zookeeper')
  attribute(:client_port, kind_of: Integer, default: 2181)
  attribute(:leader_port, kind_of: Integer, default: 2888)
  attribute(:election_port, kind_of: Integer, default: 3888)
  attribute(:ensemble, kind_of: Array, default: [])
  attribute(:properties, option_collector: true, default: {})

  def myid
    ensemble.index(instance_name).next.to_s
  end

  # Outputs the +properties+ in the Java Properties file format. This is
  # what Zookeeper daemon consumes to tweak its internal configuration.
  def to_s
    servers = ensemble.map { |n| "server.#{ensemble.index(n).next}:#{n}:#{leader_port}:#{election_port}" }
    properties.merge(
      'dataDir' => data_dir,
      'leaderPort' => leader_port,
      'clientPort' => client_port,
      'electionPort' => election_port).map { |kv| kv.join('=') }.concat(servers).join("\n")
  end

  action(:create) do
    notifying_block do
      directory ::File.dirname(new_resource.path) do
        recursive true
        mode '0755'
      end

      file ::File.join(new_resource.data_dir, 'myid') do
        content new_resource.myid
        mode '0644'
      end

      file new_resource.path do
        content new_resource.to_s
        mode '0644'
      end
    end
  end

  action(:delete) do
    notifying_block do
      directory new_resource.data_dir do
        action :delete
      end

      directory ::File.dirname(new_resource.path) do
        action :delete
      end
    end
  end
end
