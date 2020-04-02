#!/bin/bash

##############################################################################
# Copyright (c) 2020 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################

# A simple example script that publishes a number of scripts to the Nexus Repository Manager
# and executes them.
# example usage: bash repo_nexus_config.sh <password> <host IP>:<repo-nexus service's first NodePort>
#                bash repo_nexus_config.sh admin123 http://xxx.xxx.xx.xxx:xxxx

set -x

username=admin
# You can find the password in /etc/nexus-data/admin.password on the nexus repo host machine
password=$1

# add the context if you are not using the root context
host=$2

# add a script to the repository manager and run it
printf "Provisioning Integration API Scripts Starting \n\n"
printf "Publishing and executing on $host\n"

curl -u $username:$password -X POST --header 'Content-Type: application/json' $host/service/rest/v1/script -d @dockerRepositories_hosted.json
curl -u $username:$password -X GET $host/service/rest/v1/script/dockerRepositories_hosted
curl -u $username:$password -X POST --header 'Content-Type: text/plain' $host/service/rest/v1/script/dockerRepositories_hosted/run

curl -u $username:$password -X POST --header 'Content-Type: application/json' $host/service/rest/v1/script -d @dockerRepositories_proxy.json
curl -u $username:$password -X GET $host/service/rest/v1/script/dockerRepositories_proxy
curl -u $username:$password -X POST --header 'Content-Type: text/plain' $host/service/rest/v1/script/dockerRepositories_proxy/run

curl -u $username:$password -X POST --header 'Content-Type: application/json' $host/service/rest/v1/script -d @dockerRepositories_group.json
curl -u $username:$password -X GET $host/service/rest/v1/script/dockerRepositories_group
curl -u $username:$password -X POST --header 'Content-Type: text/plain' $host/service/rest/v1/script/dockerRepositories_group/run

curl -u $username:$password -X POST --header 'Content-Type: application/json' $host/service/rest/v1/script -d @realmDockerToken.json
curl -u $username:$password -X GET $host/service/rest/v1/script/realmDockerToken
curl -u $username:$password -X POST --header 'Content-Type: text/plain' $host/service/rest/v1/script/realmDockerToken/run

printf "\nProvisioning Scripts Completed\n\n"
