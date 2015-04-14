#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
module ZookeeperClusterCookbook
  def service_name
    node['zookeeper-cluster']['service_name']
  end

  def service_init_type
    node['zookeeper-cluster']['service_init_type']
  end

  def run_user
    node['zookeeper-cluster']['username']
  end

  def run_group
    node['zookeeper-cluster']['groupname']
  end

  def run_directory
    ArtifactCookbook.current_directory(service_name)
  end

  def run_environment
    {
     'JAVA_HOME' => node['java']['java_home'],
    }.merge(node['zookeeper-cluster']['environment'])
  end

  def config_filepath(cluster_name)
    File.join(config_directory, "#{cluster_name}.cfg")
  end

  def myid_filepath
    File.join(config_directory, 'myid')
  end

  def config_directory
    File.join(ArtifactCookbook.shared_path(service_name), 'conf')
  end

  def shared_directory
    ArtifactCookbook.shared_path('zookeeper')
  end
end
