#!/bin/sh

# Default values for database directory, file, and marker
DB_DIR="${EASYMESH_DB_DIR:-/var/lib/unified-wifi-mesh}"
DB_FILE="${EASYMESH_DB_FILE:-$DB_DIR/unified_wifi_mesh.db}"
DB_MARKER="${EASYMESH_DB_MARKER:-/nvram/sqlite_db_data_exists}"

# Controller onboarding should happen when the same SD card is moved to a new board.
if [ -f "$DB_MARKER" ]; then
   Last_reboot_reason="$(syscfg get X_RDKCENTRAL-COM_LastRebootReason)"
   Easymesh_db_clear="$(syscfg get easymesh_db_clear)"

   if [ "$Last_reboot_reason" = "factory-reset" ] && [ "$Easymesh_db_clear" != "true" ]; then
      echo "Factory reset detected, so wifi reset is required.."
      rm -f /nvram/sqlite_db_*
      rm -f /nvram/initial_restart_ctrl
      rm -f "$DB_FILE" "$DB_FILE-wal" "$DB_FILE-shm"

      syscfg set easymesh_db_clear true
      syscfg commit
   fi
fi
