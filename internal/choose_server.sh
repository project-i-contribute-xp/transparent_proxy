#!/usr/bin/env bash
line=0
for CONFIG in $(find ./config -name "config_*.json" | sort);
do
    echo "["$line"]"$(cat $CONFIG | jq .server)
    line=$(($line+1))
done

read -p 'Please choose server:' server

cp -f $(find ./config -name "config_*.json" | sort | sed -n $server" p") ./config.json
