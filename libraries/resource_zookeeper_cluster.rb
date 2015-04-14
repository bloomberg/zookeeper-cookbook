class Chef::Resource::ZookeeperCluster < Chef::Resource::LWRPBase
  include Poise

  actions(:create, :remove)
  default_action(:create)

  attribute(:cluster_name,
    kind_of: String,
    name_attribute: true,
    required: true,
    cannot_be: :empty)
  attribute(:cluster_node_type,
    kind_of: String,
    default: lazy { node['zookeeper-cluster']['cluster_node_type'] },
    regex: /^(participant|observer)/)
  attribute(:cluster_node_id,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['cluster_node_id'] })
  attribute(:servers,
    option_collector: true)
  attribute(:config,
    option_collector: true)
end
