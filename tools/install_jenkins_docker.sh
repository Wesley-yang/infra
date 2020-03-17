#!/bin/bash

##############################################################################
# Copyright (c) 2020 Huawei Technologies Co., Ltd.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -x

# 创建用于持久化保存jenkins repo数据的docker volume
docker volume create --name jenkins-data

# 查看创建的jenkins-data volume信息
docker volume inspect jenkins-data

# 运行jenkins 容器并挂载jenkins-data volume
docker run \
  -u root \
  -d \ 
  -p 8080:8080 \ 
  -p 50000:50000 \ 
  -v jenkins-data:/var/jenkins_home \ 
  -v /var/run/docker.sock:/var/run/docker.sock \ 
  jenkinsci/blueocean 
