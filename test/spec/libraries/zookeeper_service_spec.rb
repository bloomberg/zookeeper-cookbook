require 'poise_boiler/spec_helper'
require 'poise'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end

require_relative '../../../libraries/zookeeper_service'

describe ZookeeperClusterCookbook::Resource::ZookeeperService do
  step_into(:zookeeper_service)
  context '#action_create' do
    recipe do
      zookeeper_service 'zookeeper' do
        version '3.5.0-alpha'
      end
    end

    it { run_chef }
  end

  context '#action_disable' do
    recipe do
      zookeeper_service 'zookeeper' do
        version '3.5.0-alpha'
        action :disable
      end
    end

    it { run_chef }
  end
end
