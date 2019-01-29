#!/usr/bin/env bash
sudo pproxy -l pf://:8080 -r socks5://127.0.0.1:1080
