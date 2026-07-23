#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

LOG="$SERVER/registros/jellyfin.log"
PIDFILE="$SERVER/estado/jellyfin.pid"

mkdir -p "$SERVER/registros"
mkdir -p "$SERVER/estado"

echo "$(date) - Verificando Jellyfin" >> "$LOG"


# Verifica resposta HTTP do Jellyfin
if curl -s --max-time 5 http://127.0.0.1:8096 >/dev/null; then

    PID=$(pgrep -x jellyfin)

    if [ -n "$PID" ]; then
        echo "$PID" > "$PIDFILE"
        echo "$(date) - Jellyfin online PID $PID" >> "$LOG"
    else
        echo "$(date) - Jellyfin online (PID não identificado)" >> "$LOG"
    fi

    exit 0
fi


echo "$(date) - Jellyfin offline, iniciando" >> "$LOG"


nohup env DOTNET_ROOT=/data/data/com.termux/files/usr/lib/dotnet jellyfin >> "$LOG" 2>&1 &


sleep 20


if curl -s --max-time 5 http://127.0.0.1:8096 >/dev/null; then

    PID=$(pgrep -x jellyfin)

    echo "$PID" > "$PIDFILE"

    echo "$(date) - Jellyfin iniciado PID $PID" >> "$LOG"

else

    echo "$(date) - ERRO: Jellyfin não respondeu na porta 8096" >> "$LOG"

fi
