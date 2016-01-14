require 'spec_helper'

describe_recipe 'zookeeper-cluster::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it { expect(chef_run).to create_poise_service_user('zookeeper').with(group: 'zookeeper') }
  it { expect(chef_run).to include_recipe('selinux::disabled') }
  it { expect(chef_run).to include_recipe('java::default') }
  it { expect(chef_run).to include_recipe('rc::default') }
  it { expect(chef_run).to create_zookeeper_config('zookeeper') }
  it { expect(chef_run).to enable_zookeeper_service('zookeeper') }

  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end
