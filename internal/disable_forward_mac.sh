#!/usr/bin/env bash
echo "
nat-anchor \"com.apple/*\" all
rdr-anchor \"com.apple/*\" all
" | sudo pfctl -ef - > /dev/null

# sudo pfctl -s nat

