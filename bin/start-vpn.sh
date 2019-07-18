#!/bin/bash

sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.all.forwarding=1
sysctl net.ipv6.conf.eth0.proxy_ndp=1
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -m policy --dir out --pol ipsec -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
ip6tables -t nat -A POSTROUTING -s fd6a:6ce3:c8d8:7caa::/64 -o eth0 -m policy --dir out --pol ipsec -j ACCEPT
ip6tables -t nat -A POSTROUTING -s fd6a:6ce3:c8d8:7caa::/64 -o eth0 -j MASQUERADE

SHARED_SECRET="123$(openssl rand -base64 32 2>/dev/null)"
[ -f /etc/ipsec.secrets ] || echo ": PSK \"${SHARED_SECRET}\"" > /etc/ipsec.secrets

rm -f /var/run/starter.charon.pid

ndppd -d
/usr/sbin/ipsec start --nofork
