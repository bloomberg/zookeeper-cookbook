# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## 1.3.1
- [PR#18] Fixes problem where java-properties gem isn't loaded.

## 1.3.0
- [PR#16] Fixes service resource not restarting when upgraded.
- [PR#17] Adds support for log4j configuration.

## 1.2.0
- Fixes several issues with usage of the Poise Service cookbook.
- Fixes a few bits for testing and linting harness.

## 1.0.0
- Custom resources for managing Apache Zookeeper configuration and service lifecycle.
- Default recipe which installs Apache Zookeeper and starts service from attributes.

[PR#16]: https://github.com/bloomberg/zookeeper-cookbook/pull/16
[PR#17]: https://github.com/bloomberg/zookeeper-cookbook/pull/17
