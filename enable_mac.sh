#!/usr/bin/env bash
./disable_mac.sh

cd ./internal
./build_shadowsocks.sh
./generate_config.sh ./gui-config.json
./choose_server.sh
./startup_shadowsocks.sh
./install_pip3_on_mac.sh
./install_pproxy_on_mac.sh
./enable_forward_mac.sh
./startup_pproxy.sh
