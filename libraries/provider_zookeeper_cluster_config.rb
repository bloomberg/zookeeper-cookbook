#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'forwardable'

class Chef::Provider::ZookeeperClusterConfig < Chef::Provider::LWRPBase
  extend Forwardable
  def_delegators :@new_resource, :cluster_name, :node_type

  use_inline_resources if defined?(use_inline_resources)
  provides :zookeeper_cluster_config

  action :create do
    directory File.dirname(ZookeeperCluster.config_filename(cluster_name)) do
      recursive true
    end


  end

  action :remove do
  end
end
