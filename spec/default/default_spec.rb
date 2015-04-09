require 'spec_helper'

describe package('java-1.7.0-openjdk'), if: os[:family] == 'redhat' do
  it { should be_installed }
end
