#!/usr/bin/env bash
cd ./internal
./install_docker_on_mac.sh
./startup_docker_on_mac.sh

docker pull python:3.5-alpine
brew install curl
./build_shadowsocks.sh
./install_pip3_on_mac.sh
./install_pproxy_on_mac.sh
brew install jq

