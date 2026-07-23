#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

bash "$SERVER/web/api/status.sh"

bash "$SERVER/web/api/hardware.sh"
