# zookeeper-cluster-cookbook
[Application cookbook][0] which installs and configures
[Apache Zookeeper][1].

Apache Zookeeper is a highly-available, centralized service which is
commonly used for maintaining configuration information, distributed
service discovery and providing coordination services. This cookbook
takes a simplified approach towards configuring Apache Zookeeper.

## Platforms
This cookbook utilizes [Test Kitchen][8] to run unit and integration
tests. It is certified to run on the following platforms (these are
the ones we test in our integration tests):
- CentOS >= 6.6 (RHEL)
- Ubuntu >= 12.04

## Dependencies
This cookbook has a few required dependencies which must be uploaded
to the Chef Server. Our preferred method of doing this is to simply
use `bin/berks upload`. We have included a simple table below with
descriptions on what parts of dependency cookbooks are used.

| Cookbook Name | Usage |
| ------------- | ----- |
| [libartifact][4] | [Library cookbook][3] which manages on-disk versions of release artifacts. |
| [Poise][5] | [Library cookbook][3] which provides reusable Chef patterns. |
| [Poise Service][6] | [Library cookbook][3] which provides reusable patterns for services. |
| [SELinux][7] | [Application cookbook][0] which configures SELinux. |

## Attributes
This cookbook provides node attributes which can be used to fine tune
how the default recipe configures the instance. These node attributes
are nested where `config/properties/tickTime` would be equivalent to
`node['zookeeper-cluster']['config']['properties']['tickTime']`.

| Name | Type | Default |
| ---- | ---- | ------- |
| config/path | String | /etc/zookeeper/zoo.properties |
| config/ensemble | Array | [] |
| config/properties/tickTime | Integer | 2000 |
| config/properties/initLimit | Integer | 5 |
| config/properties/syncLimit | Integer | 2 |
| config/properties/leaderServes | String | yes |
| config/properties/forceSync | String | no |
| service_name | String | zookeeper |
| service_user | String | zookeeper |
| service_group | String | zookeeper |
| service/environment/JMXPORT | Integer | 9010 |
| service/environment/version | String | 3.5.0-alpha |

## Resources/Providers
This cookbook provides resource and provider primitives to manage
the Apache Zookeeper service locally on a node. These primitives
are what is used in the default recipe, and should be used in
your own [wrapper cookbooks][2].

### zookeeper_config
This resource is a Chef primitive which provides validation on top of
the [Apache Zookeeper service configuration][9]. It is meant to
provide a set of sane defaults and be configured using node attributes
through a [wrapper cookbook][2]. Some of the resource properties which
are made available (and are validated):

| Property | Type | Description | Default |
| -------- | ---- | ----------- | ------- |
| path | String | File system path where configuration is written. | name |
| owner | String | System username for configuration ownership. | zookeeper |
| group | String | System groupname for configuration ownership. | zookeeper |

### zookeeper_service
This resource is a Chef primitive which manages the lifecycle of the
Apache Zookeeper service on the node. Through the
[poise-service cookbook][6] it supports several different providers
for service initialization (e.g. sysvinit, systemd, upstart, etc).

| Property | Type | Description | Default |
| -------- | ---- | ----------- | ------- |
| version | String | Version of the Apache Zookeeper server. | 3.5.0-alpha |
| install_method | String | Type of way to install Apache Zookeeper. | binary |
| install_path | String | Filesystem absolute path to install Apache Zookeeper. | /srv |
| user | String | System username which Apache Zookeeper service will run as. | zookeeper |
| group | String | System groupname which Apache Zookeeper service will run as. | zookeeper |
| data_dir | String | Filesystem absolute path to the data directory. | /var/lib/zookeeper |
| log_dir | String | Filesystem absolute path to the log directory. | /var/log/zookeeper |
| config_path | String | Filesystem absolute path to the zookeeper configuration. | /etc/zookeeper/zoo.properties |

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
