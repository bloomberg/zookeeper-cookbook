name 'zookeeper-cluster'
run_list 'zookeeper-cluster::default'
default_source :community
cookbook 'zookeeper-cluster', path: '.'
