#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
module ZookeeperClusterCookbook
  module Helpers
    def run_user
      node['zookeeper-cluster']['username']
    end

    def run_group
      node['zookeeper-cluster']['groupname']
    end
  end
end
