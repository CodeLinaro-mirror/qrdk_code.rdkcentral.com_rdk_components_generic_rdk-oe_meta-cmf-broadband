#!/bin/sh

# Default values for database directory, file, and marker
DB_DIR="${EASYMESH_DB_DIR:-/var/lib/unified-wifi-mesh}"
DB_FILE="${EASYMESH_DB_FILE:-$DB_DIR/unified_wifi_mesh.db}"
DB_MARKER="${EASYMESH_DB_MARKER:-/nvram/sqlite_db_data_exists}"

# Controller onboarding should happen when the same SD card is moved to a new board.
if [ -f "$DB_MARKER" ]; then
   Existing_al_mac="$(sqlite3 -noheader -batch "$DB_FILE" "SELECT ColocatedAgentID FROM NetworkList LIMIT 1;")"
   Present_al_mac="$(ifconfig eth1_virt_peer | grep HWaddr | cut -d ' ' -f6 | tr '[:upper:]' '[:lower:]')"
   Last_reboot_reason="$(syscfg get X_RDKCENTRAL-COM_LastRebootReason)"
   Easymesh_db_clear="$(syscfg get easymesh_db_clear)"

   if [ "$Last_reboot_reason" = "factory-reset" ] && [ "$Easymesh_db_clear" != "true" ]; then
      echo "Factory reset detected, so wifi reset is required.."
      rm -f /nvram/sqlite_db_*
      rm -f /nvram/initial_restart_ctrl
      rm -f "$DB_FILE" "$DB_FILE-wal" "$DB_FILE-shm"

      syscfg set easymesh_db_clear true
      syscfg commit
   elif [ "$Present_al_mac" != "$Existing_al_mac" ]; then
      # If the AL_MAC_ADDR has changed, update the database with the new value
      Controller_mac="$(cat /sys/class/net/eth0_virt_peer/address)"
      echo "Present_al_mac $Present_al_mac is changed from $Existing_al_mac stored in DB (ctrl_al_mac $Controller_mac), updating DB..."
      if sqlite3 -noheader -batch "$DB_FILE" \
         "UPDATE NetworkList SET ControllerID = '$Controller_mac', ColocatedAgentID = '$Present_al_mac' WHERE ID = 'OneWifiMesh';"; then
         echo "AL_MAC_ADDR $Present_al_mac is set in NetworkList table in OneWifiMesh database."
      else
         echo "Failed to update AL_MAC_ADDR $Present_al_mac in NetworkList table."
      fi
   fi
fi
