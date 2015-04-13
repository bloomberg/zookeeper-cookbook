require 'spec_helper'

describe package('java-1.7.0-openjdk'), if: os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('zookeeper') do
  it { should be_enabled }
  it { should be_installed }

  case os[:family]
  when 'redhat'
    it { should be_running }
    it { should be_running.under('systemd') } unless os[:release] < 7
  when 'ubuntu'
    it { should be_running.under('upstart') }
  else
    it { should be_running }
  end
end

describe user('zookeeper') do
  it { should exist }
  it { should belong_to_group 'zookeeper' }
end

describe port(2181) do
  it { should be_listening }
end
