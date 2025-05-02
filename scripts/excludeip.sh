#!/bin/bash
# List of IP addresses to exclude
exclude_networks=(
"49.13.56.130"
"192.248.158.122"
)

# Delete any existing routes for the networks in the exclude list
for net in "${exclude_networks[@]}"; do
    sudo ip route del "$net" 2>/dev/null
done

# Fetch all non-loopback, active network interfaces
interfaces=$(ip -o link show up | awk -F': ' '{print $2}' | grep -v '^lo$')

for iface in $interfaces; do
    metric=$(ip route show dev "$iface" | awk '/metric/ {print $NF; exit}')

    # Check if metric is a number and >= 100
    if [[ "$metric" =~ ^[0-9]+$ ]] && (( metric >= 100 )); then
        gateway=$(ip route show default dev "$iface" | awk '/default/ {print $3; exit}')

        if [[ -n "$gateway" ]]; then
            for net in "${exclude_networks[@]}"; do
                echo "Adding route for $net via gateway $gateway on interface $iface"
                sudo ip route add "$net" via "$gateway" dev "$iface"
            done
            break
        fi
    fi
done
