#!/usr/bin/env bash
docker stop ss-local > /dev/null
docker run --rm \
    --name ss-local \
    -p 1080:1080 \
    -v "$(pwd)":/usr/shadowsocksr \
    -w /usr/shadowsocksr \
    -d \
    shadowsocksr \
    ss-local -c ./config.json > /dev/null; \
    sleep 2; \
    curl --proxy socks5://localhost:1080 ipecho.net/plain ; echo ;

