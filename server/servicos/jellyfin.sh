#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOG="$SERVER/registros/jellyfin.log"
PIDFILE="$SERVER/estado/jellyfin.pid"

mkdir -p "$SERVER/registros"
mkdir -p "$SERVER/estado"

echo "$(date) - Verificando Jellyfin" >> "$LOG"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date) - Jellyfin já está em execução (PID $PID)" >> "$LOG"
        exit 0
    else
        rm -f "$PIDFILE"
    fi
fi

echo "$(date) - Iniciando Jellyfin" >> "$LOG"

nohup jellyfin >> "$LOG" 2>&1 &

sleep 5

PID=$(pgrep -x "jellyfin" | head -n1)

if [ -n "$PID" ]; then
    echo "$PID" > "$PIDFILE"
    echo "$(date) - Jellyfin iniciado com PID $PID" >> "$LOG"
else
    echo "$(date) - ERRO: Jellyfin não iniciou" >> "$LOG"
fi
