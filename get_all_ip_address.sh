#!/usr/bin/env bash
./build_shadowsocks.sh
rm -rf config
mkdir config
./generate_config.sh ./gui-config.json

for CONFIG in $(find ./config -name "config_*.json" | sort);
do
    mv -f $CONFIG ./config.json;
    cat ./config.json | jq .server
    ./get_ip_address.sh;
done

