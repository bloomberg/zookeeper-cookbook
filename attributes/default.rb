#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
default['zookeeper-cluster']['config']['path'] = '/etc/zookeeper/zoo.cfg'
default['zookeeper-cluster']['config']['ensemble'] = []

default['zookeeper-cluster']['service_name'] = 'zookeeper'
default['zookeeper-cluster']['service_user'] = 'zookeeper'
default['zookeeper-cluster']['service_group'] = 'zookeeper'

default['zookeeper-cluster']['service']['environment']['JMXPORT'] = 9_010

default['zookeeper-cluster']['service']['version'] = '3.5.0-alpha'
default['zookeeper-cluster']['service']['binary_checksum'] = '87814f3afa9cf846db8d7e695e82e11480f7b19d79d8f146e58c4aefb4289bf4'
default['zookeeper-cluster']['service']['binary_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/zookeeper/zookeeper-%{version}/zookeeper-%{version}.tar.gz"
