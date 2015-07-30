# zookeeper-cluster-cookbook
[Application cookbook][0] which installs and configures
[Apache Zookeeper][1].

## Platforms
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

### zookeeper_config
| Parameter | Type | Description | Default |
| --------- | ---- | ----------- | ------- |
| path | String | File system path where configuration is written. | name |
| owner | String | System username for configuration ownership. | zookeeper |
| group | String | System groupname for configuration ownership. | zookeeper |

### zookeeper_service

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#theapplicationcookbook
[1]: https://zookeeper.apache.org
[2]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thewrappercookbook
[3]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thelibrarycookbook
[4]: https://github.com/johnbellone/libartifact-cookbook
[5]: https://github.com/poise/poise
[6]: https://github.com/poise/poise-service
