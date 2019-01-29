#!/usr/bin/env bash
open -a Docker
while [ -z "$(docker info 2> /dev/null )" ];
do printf "."; sleep 1;
done;
echo ""
