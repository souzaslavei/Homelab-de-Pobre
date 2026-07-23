#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOG="$SERVER/registros/restart.log"

echo "$(date) - Reinício manual iniciado" >> "$LOG"

echo "$(date) - Parando Dashboard Web" >> "$LOG"
pkill -f "python app.py"

echo "$(date) - Parando Jellyfin" >> "$LOG"
pkill -f "jellyfin"

echo "$(date) - Parando Transmission" >> "$LOG"
pkill -f "transmission-daemon"

echo "$(date) - Parando File Browser" >> "$LOG"
pkill -f "filebrowser --database"

sleep 3

echo "$(date) - Iniciando File Browser" >> "$LOG"
"$SERVER/servicos/filebrowser.sh"

sleep 2

echo "$(date) - Iniciando Transmission" >> "$LOG"
"$SERVER/servicos/transmission.sh"

sleep 2

echo "$(date) - Iniciando Jellyfin" >> "$LOG"
"$SERVER/servicos/jellyfin.sh"

sleep 5

echo "$(date) - Iniciando Dashboard Web" >> "$LOG"
"$SERVER/servicos/web.sh"

echo "$(date) - Reinício manual concluído" >> "$LOG"
