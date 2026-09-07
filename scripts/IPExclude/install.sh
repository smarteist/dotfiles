#!/bin/bash

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Constants
APP_NAME="ipexclude"
PREFIX="/usr/local"
BINDIR="${PREFIX}/bin"
SYSCONFDIR="/etc"
CONFIG_DIR="${SYSCONFDIR}/${APP_NAME}"
DISPATCHER_DIR="${SYSCONFDIR}/NetworkManager/dispatcher.d"
DISPATCHER_NAME="99-${APP_NAME}"

# Create directories
install -d "${BINDIR}"
install -d "${CONFIG_DIR}"
install -d "${DISPATCHER_DIR}"

# Install executable
install -m 755 ipexclude.sh "${BINDIR}/${APP_NAME}"

# Create default config file if it does not exist
if [ ! -f "${CONFIG_DIR}/${APP_NAME}.txt" ]; then
    touch "${CONFIG_DIR}/${APP_NAME}.txt"
    chmod 644 "${CONFIG_DIR}/${APP_NAME}.txt"
fi

# Install dispatcher script
install -m 755 dispatcher.sh "${DISPATCHER_DIR}/${DISPATCHER_NAME}"