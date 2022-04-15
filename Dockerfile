#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

ARG JDK_VERSION=debian-jre
FROM busybox as builder

ARG DRUID_VERSION=0.22.1

COPY druid/distribution/target/apache-druid-${DRUID_VERSION}-bin.tar.gz /src/
WORKDIR /src
RUN mkdir -p /opt \
 && tar -zxf ./apache-druid-${DRUID_VERSION}-bin.tar.gz -C /opt \
 && mv /opt/apache-druid-${DRUID_VERSION} /opt/druid

FROM adoptopenjdk/openjdk8:$JDK_VERSION
LABEL maintainer="Anurag Agarwal <anurag.agarwal561994@gmail.com>"

RUN addgroup --system --gid 1000 druid \
 && adduser --system --uid 1000 --disabled-password --no-create-home --home /opt/druid --shell /bin/sh --gecos '' --ingroup druid druid

COPY --chown=druid:druid --from=builder /opt /opt
COPY druid/distribution/docker/druid.sh /druid.sh

# create necessary directories which could be mounted as volume
#   /opt/druid/var is used to keep individual files(e.g. log) of each Druid service
#   /opt/shared is used to keep segments and task logs shared among Druid services
RUN mkdir /opt/druid/var /opt/shared \
 && chown druid:druid /opt/druid/var /opt/shared \
 && chmod 775 /opt/druid/var /opt/shared

USER druid
VOLUME /opt/druid/var
WORKDIR /opt/druid

ENTRYPOINT ["/druid.sh"]
