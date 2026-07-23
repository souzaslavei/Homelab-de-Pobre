#!/data/data/com.termux/files/usr/bin/bash

LOG="$HOME/server/registros/filebrowser.log"
PIDFILE="$HOME/server/estado/filebrowser.pid"
DB="$HOME/server/dados/filebrowser/filebrowser.db"
ROOT="/data/data/com.termux/files/home/storage/shared/"

mkdir -p "$HOME/server/registros"
mkdir -p "$HOME/server/dados/filebrowser"
mkdir -p "$HOME/server/estado"

echo "$(date) - Verificando File Browser" >> "$LOG"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date) - File Browser já está em execução (PID $PID)" >> "$LOG"
        exit 0
    fi
fi

echo "$(date) - Iniciando File Browser" >> "$LOG"

nohup filebrowser \
--database "$DB" \
--address "0.0.0.0" \
--port "8080" \
-r "$ROOT" \
>> "$LOG" 2>&1 &

PID=$!

echo "$PID" > "$PIDFILE"

echo "$(date) - File Browser iniciado com PID $PID" >> "$LOG"
