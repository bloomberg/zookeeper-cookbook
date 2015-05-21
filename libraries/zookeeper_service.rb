#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ZookeeperService < Chef::Resource
  include Poise(fused: true)
  provides(:zookeeper_service)
  actions(:create, :delete, :start, :stop, :restart)

  attribute(:service_name,
            kind_of: String,
            name_attribute: true,
            cannot_be: :empty)
  attribute(:service_type,
            kind_of: [Symbol, NilClass],
            default: nil)
  attribute(:run_user,
            kind_of: String,
            default: 'zookeeper')
  attribute(:run_group,
            kind_of: String,
            default: 'zookeeper')
  attribute(:config_filepath,
            kind_of: String)

  action(:create) do
    poise_service_user new_resource.run_user do
      group new_resource.run_group
    end

    poise_service new_resource.service_name do
      provider new_resource.service_type
      user new_resource.run_user
      group new_resource.run_group
    end
  end

  action(:delete) do

  end

end
