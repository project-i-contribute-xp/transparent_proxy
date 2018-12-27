#!/usr/bin/env bash
./build_shadowsocks.sh
docker run --rm \
    -p 1080:1080 \
    -v "$(pwd)/config":/usr/shadowsocksr \
    -w /usr/shadowsocksr \
    shadowsocksr \
    ss-local -c ./config.json

