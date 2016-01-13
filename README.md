# zookeeper-cluster-cookbook
[![Build Status](https://img.shields.io/travis/bloomberg/zookeeper-cookbook.svg)](https://travis-ci.org/bloomberg/zookeeper-cookbook)
[![Code Quality](https://img.shields.io/codeclimate/github/bloomberg/zookeeper-cookbook.svg)](https://codeclimate.com/github/bloomberg/zookeeper-cookbook)
[![Cookbook Version](https://img.shields.io/cookbook/v/zookeeper-cluster.svg)](https://supermarket.chef.io/cookbooks/zookeeper-cluster)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

[Application cookbook][0] which installs and configures
[Apache Zookeeper][1].

Apache Zookeeper is a highly-available, centralized service which is
commonly used for maintaining configuration information, distributed
service discovery and providing coordination services. This cookbook
takes a simplified approach towards configuring Apache Zookeeper.

## Basic Usage
This cookbook was designed from the ground up to make it dead simple
to install and configure a Zookeeper cluster using Chef. It also highlights
several of our best practices for developing reusable Chef cookbooks
at Bloomberg.

This cookbook provides [node attributes](attributes/default.rb) which
can be used to fine tune the default recipe which installs and
configures Zookeeper. The values from the node attributes are passed
directly into the configuration and service resources.

Out of the box the following platforms are certified to work and
are tested using our [Test Kitchen][8] configuration. Additional platforms
_may_ work, but your mileage may vary.
- CentOS (RHEL) 6.6, 7.1
- Ubuntu 12.04, 14.04

The correct way to use this cookbook is to create a
[wrapper cookbook][2] which configures all of the members of the
Zookeeper ensemble (cluster). We do this by using a data bag for each
Chef environment. The default recipe in your wrapper cookbook may
look something like the following block:
```ruby
bag = data_bag_item('config', 'zookeeper')[node.chef_environment]
node.default['zookeeper-cluster']['config']['instance_name'] = node['ipaddress']
node.default['zookeeper-cluster']['config']['ensemble'] = bag['ensemble']
include_recipe 'zookeeper-cluster::default'
```

The data bag for the above block should have an array of
fully-qualified hostnames, the _exact_ ones that appear in
`node['fqdn']`, which represent the members of the Zookeeper
ensemble. These hostnames are used when configuring the Zookeeper
service on each node.
```json
{
  "id": "zookeeper",
  "development": {
    "zk1.dev.inf.example.com",
    "zk2.dev.inf.example.com",
    "zk3.dev.inf.example.com"
  },
  "production": {
    "zk1.prod.inf.example.com",
    "zk2.prod.inf.example.com",
    "zk3.prod.inf.example.com",
    "zk4.prod.inf.example.com",
    "zk5.prod.inf.example.com",
  }
}
```

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#theapplicationcookbook
[1]: https://zookeeper.apache.org
[2]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thewrappercookbook
[3]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thelibrarycookbook
[4]: https://github.com/johnbellone/libartifact-cookbook
[5]: https://github.com/poise/poise
[6]: https://github.com/poise/poise-service
[7]: https://github.com/skottler/selinux
[8]: https://github.com/test-kitchen/test-kitchen
[9]: https://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html
