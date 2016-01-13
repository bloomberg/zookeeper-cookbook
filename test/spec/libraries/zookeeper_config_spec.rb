require 'chefspec'
require 'chefspec/berkshelf'
require 'poise_boiler/spec_helper'
require_relative '../../../libraries/zookeeper_config'

describe ZookeeperClusterCookbook::Resource::ZookeeperConfig do
  step_into(:zookeeper_config)
  context '#action_create' do
    recipe do
      zookeeper_config '/etc/zookeeper/zoo.properties' do
        instance_name 'a'
        ensemble %w{a b c}
      end
    end

    it { is_expected.to create_directory('/etc/zookeeper').with(recursive: true) }
    it { is_expected.to create_file('/var/lib/zookeeper/myid') }
    it do
      is_expected.to create_file('/etc/zookeeper/zoo.properties')
    end
    it do
      is_expected.to create_directory('/var/lib/zookeeper')
      .with(owner: 'zookeeper', group: 'zookeeper')
      .with(recursive: true)
    end
  end

  context '#action_delete' do
    recipe do
      zookeeper_config '/etc/zookeeper/zoo.properties' do
        instance_name 'a'
        ensemble %w{a b c}
        action :delete
      end
    end

    it { is_expected.to delete_directory('/var/lib/zookeeper') }
    it { is_expected.to delete_directory('/etc/zookeeper') }
  end
end
