#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
module ZookeeperClusterCookbook
  module Config
    def config_filepath(cluster_name)
      File.join(config_directory, "#{cluster_name}.cfg")
    end

    def myid_filepath
      File.join(config_directory, 'myid')
    end

    def config_directory
      File.join(ArtifactCookbook.shared_path('zookeeper'), 'conf')
    end

    def run_user
      node['zookeeper-cluster']['username']
    end

    def run_group
      node['zookeeper-cluster']['groupname']
    end
  end
end
