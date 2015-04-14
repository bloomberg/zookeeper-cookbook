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

    def shared_directory
      ArtifactCookbook.shared_path('zookeeper')
    end

    def run_user
      node['zookeeper-cluster']['username']
    end

    def run_group
      node['zookeeper-cluster']['groupname']
    end

    # @see https://github.com/zk-ruby/zk-server/blob/master/lib/zk-server/config.rb#L270-300
    def config_to_file_str(config)
      %w[leaderServes skipACL forceSync].each do |yorn_key|
      if config.has_key?(yorn_key)
        config[yorn_key] = config[york_key] ? 'yes' : 'no'
      end
      config.sort.map { |k,v| kv.join('=') }.join("\n")
    end

    end
  end
end
