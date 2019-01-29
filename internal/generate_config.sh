#!/usr/bin/env bash
rm -rf ./config
mkdir config

docker run --rm \
    -v "$(pwd)":/usr/python \
    -w /usr/python \
    python:3.5-alpine \
    python ./generate_config.py $1

