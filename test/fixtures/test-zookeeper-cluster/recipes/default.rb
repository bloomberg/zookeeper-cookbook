node.default['zookeeper-cluster']['config']['ensemble'] = [ node['hostname'] ]
include_recipe 'zookeeper-cluster::default'
