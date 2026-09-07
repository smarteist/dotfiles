#!/bin/sh

INTERFACE="$1"
ACTION="$2"

# Constants
APP_NAME="ipexclude"
APP_PATH="/usr/local/bin/${APP_NAME}"
CONF_DIR="/etc/${APP_NAME}"

# Only trigger on link up
if [ "$ACTION" = "up" ]; then
    logger -t "${APP_NAME}-dispatcher" "Interface ${INTERFACE} up. Executing ${APP_NAME}."

    # Pass all config files to executable
    find "${CONF_DIR}" -type f | xargs -r "${APP_PATH}" 2>&1 | logger -t "${APP_NAME}"
fi

exit 0
