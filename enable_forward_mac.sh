#!/usr/bin/env bash
# sudo sysctl -w net.inet.ip.forwarding=0
echo "
nat-anchor \"com.apple/*\" all
rdr-anchor \"com.apple/*\" all
rdr pass on lo0 inet proto tcp from any to any port {443,80,22} -> 127.0.0.1 port 8080
pass out on en0 route-to lo0 inet proto tcp from any to any port {443,80,22} keep state
" | sudo pfctl -ef -
# " | sudo pfctl -vn -ef -

# rdr pass on lo0 inet proto tcp from any to any port {80, 443} -> 127.0.0.1 port 1080
# pass out on en0 route-to lo0 inet proto tcp from any to any port {80, 443}
# nat proto {tcp} from any to any port {80, 443} -> 127.0.0.1 port 1080
# nat proto {tcp} from 192.168.100.105 to any port {80, 443} -> 127.0.0.1 port 1080
# binat proto {tcp} from any to any port {80, 443} -> 127.0.0.1 port 1080
# nat proto {tcp} from 192.168.100.105 to any port {80, 443} -> 192.168.1.1
# " | sudo pfctl -vn -ef -
# block proto {tcp} from any to any port {80}
# rdr proto {tcp} from any to any port {80, 443} -> 127.0.0.1 port 1090
sudo pfctl -s nat

