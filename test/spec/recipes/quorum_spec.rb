require 'spec_helper'

describe_recipe 'zookeeper-cluster::quorum' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  it { expect(chef_run).to include_recipe('zookeeper-cluster::default') }

  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end
