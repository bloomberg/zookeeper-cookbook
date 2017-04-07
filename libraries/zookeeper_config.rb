#
# Cookbook: zookeeper-cluster
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
require 'poise'

module ZookeeperClusterCookbook
  module Resource
    # A `zookeeper_config` fused resource which manages a
    # configuration for Zookeeper.
    # @action enable
    # @action disable
    # @action start
    # @action stop
    # @action restart
    # @action reload
    # @since 1.0
    class ZookeeperConfig < Chef::Resource
      include Poise(fused: true)
      provides(:zookeeper_config)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String, default: 'zookeeper')
      attribute(:group, kind_of: String, default: 'zookeeper')

      attribute(:instance_name, kind_of: String, required: true)
      attribute(:instance_id, kind_of: String, default: lazy { ensemble.index(instance_name).next.to_s })
      alias_method :myid, :instance_id
      attribute(:data_dir, kind_of: String, default: '/var/lib/zookeeper')
      attribute(:client_port, kind_of: Integer, default: 2181)
      attribute(:leader_port, kind_of: Integer, default: 2888)
      attribute(:election_port, kind_of: Integer, default: 3888)
      attribute(:ensemble, kind_of: Array, default: [], required: true)
      attribute(:properties, option_collector: true, default: {})

      # Outputs the +properties+ in the Java Properties file format. This is
      # what Zookeeper daemon consumes to tweak its internal configuration.
      def to_s
        if properties.key?(:dynamicConfigFile)
          properties.merge(
              'dataDir' => data_dir,
              'leaderPort' => leader_port,
              'clientPort' => client_port,
              'electionPort' => election_port).map { |kv| kv.join('=') }.join("\n")
        else
          servers = ensemble.map { |n| "server.#{ensemble.index(n).next}:#{n}:#{leader_port}:#{election_port}" }
          properties.merge(
            'dataDir' => data_dir,
            'leaderPort' => leader_port,
            'clientPort' => client_port,
            'electionPort' => election_port).map { |kv| kv.join('=') }.concat(servers).join("\n")
        end
      end


      action(:create) do
        notifying_block do
          directory ::File.dirname(new_resource.path) do
            recursive true
            mode '0755'
          end

          directory new_resource.data_dir do
            owner new_resource.owner
            group new_resource.group
            recursive true
            mode '0755'
          end

          file ::File.join(new_resource.data_dir, 'myid') do
            content new_resource.myid
            mode '0644'
          end

          # create zoo.properties.static file and only update 
          # zoo.properties when static file has changed.
          # this is needed to ensure chef won't constantly update
          # zoo.properties and force restarts of zookeeper when
          # it dynamically updates zoo.properties.
          file new_resource.path+".static" do
            content new_resource.to_s
            mode '0644'
            notifies :create, 'file[config_base]', :immediately
          end

          file 'config_base' do
            content new_resource.to_s
            path new_resource.path
            mode '0644'
            action :nothing       
          end
        end
      end

      action(:delete) do
        notifying_block do
          directory new_resource.data_dir do
            action :delete
          end

          directory ::File.dirname(new_resource.path) do
            action :delete
          end
        end
      end
    end
  end
end
