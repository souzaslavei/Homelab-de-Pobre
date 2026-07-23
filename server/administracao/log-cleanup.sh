#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOGDIR="$SERVER/registros"
MAINLOG="$LOGDIR/startup.log"

mkdir -p "$LOGDIR"

echo "$(date) - Iniciando limpeza de logs" >> "$MAINLOG"

for LOG in "$LOGDIR"/*.log
do
    [ -f "$LOG" ] || continue

    SIZE=$(du -k "$LOG" | awk '{print $1}')

    if [ "$SIZE" -gt 10240 ]; then
        echo "$(date) - Compactando $(basename "$LOG") (${SIZE}KB)" >> "$MAINLOG"

        tail -5000 "$LOG" > "$LOG.tmp"
        mv "$LOG.tmp" "$LOG"
    fi
done

echo "$(date) - Limpeza de logs concluída" >> "$MAINLOG"
