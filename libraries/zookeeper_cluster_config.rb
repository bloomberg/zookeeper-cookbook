#
# Cookbook: zookeeper-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
module ZookeeperCluster
  module Config
    class << self
      def connection_timeout
      end

      def cluster_name
      end

      def tick_time
      end

      def filename
        File.join(ArtifactCookbook.shared_path('zookeeper'), 'conf', "#{cluster_name}.cfg")
      end

      def client_address
      end

      def min_session_timeout
      end

      def max_session_timeout
      end

      def max_client_connections
      end

      def trace_file
      end

      def snap_count
      end

      def client_port
      end

      def election_port
      end

      def leader_port
      end

      def data_log_directory
      end

      def global_outstanding_limit
      end

      def pre_alloc_size
      end

      def election_algorithm
      end

      def sync_limit
      end

      def init_limit
      end

      def leader_serves?
      end

      def force_sync?
      end

      def skip_acl?
      end
    end
  end
end
