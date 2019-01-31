#!/usr/bin/env bash
echo "
nat-anchor \"com.apple/*\" all
rdr-anchor \"com.apple/*\" all
rdr pass on lo0 inet proto tcp from any to !127.0.0.1 -> 127.0.0.1 port 8080
pass out on en0 route-to lo0 inet proto tcp from any to any port != "$1" keep state
" | sudo pfctl -ef - > /dev/null
# " | sudo pfctl -vn -ef -

# sudo pfctl -s nat

