#!/bin/bash

set -x


# drill short txt ch whoami.cloudflare @1.0.0.1 | sed -e '/^;;/d' -e '/^$/d' | cut -d '"' -f2

PUBLIC_IP=$(curl -s https://www.cloudflare.com/cdn-cgi/trace | grep '^ip=' | cut -d= -f2)
INTERFACE=$(ip route list | awk '/^default/ {print $5}')
IPETH=$(ip -o -f inet addr show $INTERFACE | awk '{print $4}'| cut -d "/" -f1)
MASK=$(ip -o -f inet addr show $INTERFACE | awk '{print $4}'| cut -d "/" -f2)
DEFAULT_GW=$(ip route show 0.0.0.0/0 dev $INTERFACE | cut -d\  -f3)


ip rule add table 128 from $PUBLIC_IP
ip route add table 128 to $IPETH/$MASK dev $INTERFACE
ip route add table 128 default via $DEFAULT_GW
