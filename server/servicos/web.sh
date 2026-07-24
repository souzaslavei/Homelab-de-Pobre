#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

LOG="$SERVER/registros/web.log"
PIDFILE="$SERVER/estado/web.pid"

mkdir -p "$SERVER/registros"
mkdir -p "$SERVER/estado"

echo "$(date) - Verificando Dashboard Web" >> "$LOG"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date) - Dashboard Web já está em execução (PID $PID)" >> "$LOG"
        exit 0
    fi
fi

echo "$(date) - Iniciando Dashboard Web" >> "$LOG"

cd "$SERVER/web"

nohup python app.py >> "$LOG" 2>&1 &

sleep 2

PID=$(pgrep -f "python app.py" | head -n1)

[ -n "$PID" ] && echo "$PID" > "$PIDFILE"

echo "$(date) - Dashboard Web iniciado com PID $PID" >> "$LOG"
