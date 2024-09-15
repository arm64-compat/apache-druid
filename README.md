# Druid ARM64 Compatible Image

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/arm64-compat/apache-druid/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/arm64-compat/apache-druid/tree/main)
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

`adoptopenjdk/openjdk8` base image is used with `<arch>-debian-jre<version>` flavour.

## Druid Operator Usage

In your CRD for setting up druid, change your image

from

```yaml
image: apache/druid:25.0.0
```

to

```yaml
image: ghcr.io/arm64-compat/apache/druid:25.0.0
```

## Git Submodule upgrade

Process to upgrade submodule:

    1.- git checkout -b 10-upgrade-to-3000
    2.- git submodule init
    3.- git submodule update --remote druid
    4.- git submodule foreach --recursive 'git fetch --tags'
    5.- cd druid
    6.- git checkout <tag> (e.g. git checkout druid-30.0.0)
    7.- cd ..
    8.- git add druid
    9.- git submodule status 
    10.- git commit -m "Upgrade to 30.0.0" 
    11.- git push -u origin 10-upgrade-to-3000

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
