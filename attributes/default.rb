#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
default['zookeeper-cluster']['cluster_name'] = 'zookeeper'
default['zookeeper-cluster']['cluster_node_type'] = 'participant'
default['zookeeper-cluster']['cluster_node_id'] = 1

default['zookeeper-cluster']['jvm']['server_jvmflags'] = ''
default['zookeeper-cluster']['jvm']['jmxport'] = 9_010

default['zookeeper-cluster']['username'] = 'zookeeper'
default['zookeeper-cluster']['groupname'] = 'zookeeper'

default['zookeeper-cluster']['service_name'] = 'zookeeper'
default['zookeeper-cluster']['service_init_type'] = :sysvinit

default['zookeeper-cluster']['version'] = '3.4.6'
default['zookeeper-cluster']['remote_checksum'] = '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
default['zookeeper-cluster']['remote_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/zookeeper/zookeeper-%{version}/zookeeper-%{version}.tar.gz"
