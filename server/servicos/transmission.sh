#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

LOG="$SERVER/registros/transmission.log"
PIDFILE="$SERVER/estado/transmission.pid"
CONFIG="$SERVER/dados/transmission"

mkdir -p "$SERVER/registros"
mkdir -p "$SERVER/estado"
mkdir -p "$CONFIG"

echo "$(date) - Verificando Transmission" >> "$LOG"


# Verifica PID existente

if [ -f "$PIDFILE" ]; then

    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then

        echo "$(date) - Transmission já está em execução (PID $PID)" >> "$LOG"
        exit 0

    else

        echo "$(date) - PID antigo encontrado, removendo" >> "$LOG"
        rm -f "$PIDFILE"

    fi

fi


# Evita segunda instância

if pgrep -x transmission-daemon >/dev/null; then

    PID=$(pgrep -x transmission-daemon | head -n1)

    echo "$(date) - Transmission encontrado ativo (PID $PID)" >> "$LOG"

    echo "$PID" > "$PIDFILE"

    exit 0

fi


echo "$(date) - Iniciando Transmission" >> "$LOG"


nohup transmission-daemon \
-g "$CONFIG" \
-x "$PIDFILE" \
-e "$LOG" \
>/dev/null 2>&1 &


sleep 3


if [ -f "$PIDFILE" ]; then

    PID=$(cat "$PIDFILE")

    echo "$(date) - Transmission iniciado com PID $PID" >> "$LOG"

else

    echo "$(date) - ERRO: PID não criado" >> "$LOG"

    exit 1

fi
