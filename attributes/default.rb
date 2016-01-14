#
# Cookbook: zookeeper-cluster
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
default['zookeeper-cluster']['config']['path'] = '/etc/zookeeper/zoo.properties'
default['zookeeper-cluster']['config']['ensemble'] = []
default['zookeeper-cluster']['config']['properties']['tickTime'] = 2_000
default['zookeeper-cluster']['config']['properties']['initLimit'] = 5
default['zookeeper-cluster']['config']['properties']['syncLimit'] = 2
default['zookeeper-cluster']['config']['properties']['leaderServes'] = 'yes'
default['zookeeper-cluster']['config']['properties']['forceSync'] = 'no'

default['zookeeper-cluster']['service_name'] = 'zookeeper'
default['zookeeper-cluster']['service_user'] = 'zookeeper'
default['zookeeper-cluster']['service_group'] = 'zookeeper'

default['zookeeper-cluster']['service']['environment']['ZOOCFGDIR'] = '/etc/zookeeper'
default['zookeeper-cluster']['service']['environment']['JMXPORT'] = 9_010
default['zookeeper-cluster']['service']['version'] = '3.5.0-alpha'
default['zookeeper-cluster']['service']['binary_checksum'] = '87814f3afa9cf846db8d7e695e82e11480f7b19d79d8f146e58c4aefb4289bf4'
default['zookeeper-cluster']['service']['binary_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/zookeeper/zookeeper-%{version}/zookeeper-%{version}.tar.gz" # rubocop:disable Style/StringLiterals

default['zookeeper-cluster']['log4j']['path'] = '/etc/zookeeper/log4j.properties'

default['zookeeper-cluster']['log4j']['properties']['zookeeper.root.logger'] = 'INFO, ROLLINGFILE'
default['zookeeper-cluster']['log4j']['properties']['zookeeper.console.threshold'] = 'INFO'
default['zookeeper-cluster']['log4j']['properties']['zookeeper.log.dir'] = '.'
default['zookeeper-cluster']['log4j']['properties']['zookeeper.log.file'] = 'zookeeper.log'
default['zookeeper-cluster']['log4j']['properties']['zookeeper.log.threshold'] = 'INFO'
default['zookeeper-cluster']['log4j']['properties']['zookeeper.tracelog.dir'] = '.'
default['zookeeper-cluster']['log4j']['properties']['zookeeper.tracelog.file'] = 'zookeeper_trace.log'

default['zookeeper-cluster']['log4j']['properties']['log4j.rootLogger'] = '${zookeeper.root.logger}'

default['zookeeper-cluster']['log4j']['properties']['log4j.appender.CONSOLE'] = 'org.apache.log4j.ConsoleAppender'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.CONSOLE.Threshold'] = '${zookeeper.console.threshold}'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.CONSOLE.layout'] = 'org.apache.log4j.PatternLayout'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.CONSOLE.layout.ConversionPattern'] = '%d{ISO8601} [myid:%X{myid}] - %-5p [%t:%C{1}@%L] - %m%n'

default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE'] = 'org.apache.log4j.RollingFileAppender'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE.Threshold'] = '${zookeeper.log.threshold}'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE.File'] = '${zookeeper.log.dir}/${zookeeper.log.file}'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE.MaxFileSize'] = '10MB'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE.MaxBackupIndex'] = '25'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE.layout'] = 'org.apache.log4j.PatternLayout'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.ROLLINGFILE.layout.ConversionPattern'] = '%d{ISO8601} [myid:%X{myid}] - %-5p [%t:%C{1}@%L] - %m%n'

default['zookeeper-cluster']['log4j']['properties']['log4j.appender.TRACEFILE'] = 'org.apache.log4j.FileAppender'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.TRACEFILE.Threshold'] = 'TRACE'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.TRACEFILE.File'] = '${zookeeper.tracelog.dir}/${zookeeper.tracelog.file}'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.TRACEFILE.layout'] = 'org.apache.log4j.PatternLayout'
default['zookeeper-cluster']['log4j']['properties']['log4j.appender.TRACEFILE.layout.ConversionPattern'] = '%d{ISO8601} [myid:%X{myid}] - %-5p [%t:%C{1}@%L][%x] - %m%n'
