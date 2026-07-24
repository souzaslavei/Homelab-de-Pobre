#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

# Ambiente .NET necessário para Jellyfin no Termux
export DOTNET_ROOT="/data/data/com.termux/files/usr/lib/dotnet"
export PATH="$DOTNET_ROOT:$PATH"
export DOTNET_BUNDLE_EXTRACT_BASE_DIR="$HOME/.cache/dotnet_bundle_extract"

LOG="$SERVER/registros/jellyfin.log"
PIDFILE="$SERVER/estado/jellyfin.pid"

mkdir -p "$SERVER/registros"
mkdir -p "$SERVER/estado"

echo "$(date) - Verificando Jellyfin" >> "$LOG"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date) - Jellyfin já está rodando (PID $PID)" >> "$LOG"
        exit 0
    else
        echo "$(date) - PID antigo removido" >> "$LOG"
        rm -f "$PIDFILE"
    fi
fi

echo "$(date) - Iniciando Jellyfin" >> "$LOG"

nohup jellyfin >> "$LOG" 2>&1 &

PID=$!

echo "$PID" > "$PIDFILE"

echo "$(date) - Processo Jellyfin criado com PID $PID" >> "$LOG"

for i in {1..12}; do
    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date) - Jellyfin confirmado ativo (PID $PID)" >> "$LOG"
        exit 0
    fi

    sleep 5
done

echo "$(date) - ERRO: Jellyfin morreu durante inicialização" >> "$LOG"
rm -f "$PIDFILE"

exit 1
