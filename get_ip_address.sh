#!/usr/bin/env bash
./startup_shadowsocks.sh
sleep 2
curl --proxy socks5://localhost:1080 ipecho.net/plain ; echo

