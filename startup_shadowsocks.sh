#!/usr/bin/env bash
./build_shadowsocks.sh
docker stop ss-local

docker run --rm \
    --name ss-local \
    -p 1080:1080 \
    -v "$(pwd)/config":/usr/shadowsocksr \
    -w /usr/shadowsocksr \
    -d \
    shadowsocksr \
    ss-local -c ./config.json

