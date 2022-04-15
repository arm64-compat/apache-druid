# Druid ARM64 Compatible Image

[![Build Status](https://app.travis-ci.com/arm64-compat/apache-druid.svg?branch=main)](https://app.travis-ci.com/arm64-compat/apache-druid)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This repository provides `linux/amd64` & `linux/arm64` compatible images for [Apach Druid](https://github.com/apache/druid) project. These images can be used with [Durid Operator HELM Chart](https://github.com/druid-io/druid-operator).

Images are natively built and not using QEMU emulation support thus are faster when used with compatible CPU architecture.

**Note**: images are only for development purposes and has not been tested for production ready use-cases.

As Mac M1 chip processor laptops are becoming increasily popular, running incompatible containers are slower and impacts productive. Enumlated images are resource hungry and doesn't let you leverage the benefits of M1 Chip.

This repo is inspired from [bitnami-compat](https://github.com/ZCube/bitnami-compat).

## Supported Images & Tags

Since these images are meant to be only used for development purposes, vast variety of support for different flavors is not provided. However if there is enough interests, contributions are welcome.

You can refer to [GHCR Package Repository](https://github.com/orgs/arm64-compat/packages/container/package/apache%2Fdruid) for details on the available versions and tags.

### Base Image

`adoptopenjdk/openjdk8` base image is used with `debian-jre` flavour.

### Automated Builds

Travis-CI builds are scheduled to run on weekly basis. It keeps track of [Druid Releases](https://github.com/apache/druid/releases) and it will create a new image for a new version released without making much changes to the source code in most of the cases

## Druid Operator Usage

In your CRD for setting up druid, change your image

from

```yaml
image: apache/druid:0.22.1
```

to

```yaml
image: ghcr.io/arm64-compat/apache/druid:0.22.1
```

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
