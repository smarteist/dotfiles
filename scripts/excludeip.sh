#!/bin/bash

# Constants
ROUTE_FILE="/proc/net/route"
MIN_CIDR_LEN=7

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <cidr_file1> [cidr_file2 ...]" >&2
    exit 1
fi

# Parse /proc/net/route directly to match C logic exactly
IFACE=""
GW=""

while read -r iface dest gw rest; do
    # Skip header
    if [ "$iface" = "Iface" ]; then continue; fi

    # Check for default destination and non-zero gateway
    if [ "$dest" = "00000000" ] && [ "$gw" != "00000000" ]; then
        # Convert hex gateway string (little-endian) to IP address
        printf -v o4 "%d" "0x${gw:0:2}"
        printf -v o3 "%d" "0x${gw:2:2}"
        printf -v o2 "%d" "0x${gw:4:2}"
        printf -v o1 "%d" "0x${gw:6:2}"

        GW="$o1.$o2.$o3.$o4"
        IFACE="$iface"
        break
    fi
done < "$ROUTE_FILE"

if [ -z "$IFACE" ] || [ -z "$GW" ]; then
    echo "No active interface found." >&2
    exit 1
fi

echo "Interface: $IFACE, Gateway: $GW"

# Build and execute route batch
BATCH_CMDS=$(
    for FILE in "$@"; do
        if [ ! -f "$FILE" ]; then
            echo "Cannot read $FILE" >&2
            continue
        fi

        # Strip carriage returns and generate batch lines
        awk -v gw="$GW" -v iface="$IFACE" -v min_len="$MIN_CIDR_LEN" '
            {
                sub(/\r$/, "", $0);
                if (length($0) >= min_len) {
                    print "route replace " $0 " via " gw " dev " iface
                }
            }
        ' "$FILE"
    done
)

NET_COUNT=$(echo -n "$BATCH_CMDS" | grep -c '^' || true)

# Apply routes in batch
if [ "$NET_COUNT" -gt 0 ]; then
    echo "Applying $NET_COUNT routes..."
    echo "$BATCH_CMDS" | ip -batch -
    echo "Configured routes for $NET_COUNT networks."
fi
