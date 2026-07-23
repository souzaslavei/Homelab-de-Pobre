#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/instalacao/scripts/lib/instalador.sh"


CONFIG="$SERVER/dados/transmission"
SETTINGS="$CONFIG/settings.json"

DOWNLOADS="/storage/emulated/0/Home/Downloads"

LOG="$SERVER/registros/transmission.log"
PIDFILE="$SERVER/estado/transmission.pid"

mkdir -p "$CONFIG"
mkdir -p "$SERVER/registros"
mkdir -p "$SERVER/estado"

echo "Configurando Transmission..."

echo "Gerando configuração padrão..."

transmission-daemon \
-g "$CONFIG" \
-w "$DOWNLOADS/concluidos" \
--incomplete-dir "$DOWNLOADS/temporarios" \
-x "$PIDFILE" \
-e "$LOG" \
>/dev/null 2>&1 &

sleep 5

if [ -f "$PIDFILE" ]; then

    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then

        kill "$PID"

        sleep 5

        if kill -0 "$PID" 2>/dev/null; then
            kill -9 "$PID"
            sleep 2
        fi

    fi

    rm -f "$PIDFILE"

fi

sleep 2

if [ ! -f "$SETTINGS" ]; then
    echo "ERRO: settings.json não foi criado."
    exit 1
fi

echo "Aplicando configurações..."

python - <<PY
import json

path="$SETTINGS"

with open(path) as f:
    data=json.load(f)

data["rpc-bind-address"]="0.0.0.0"
data["rpc-whitelist-enabled"]=False
data["rpc-host-whitelist-enabled"]=False

data["download-dir"]="$DOWNLOADS/concluidos"
data["incomplete-dir"]="$DOWNLOADS/temporarios"
data["incomplete-dir-enabled"]=True

with open(path,"w") as f:
    json.dump(data,f,indent=4)

PY

# Criar arquivo de acesso

ACESSO="$SERVER/dados/transmission/acesso.conf"

if [ ! -f "$ACESSO" ]; then

    URL_SERVICO="$(obter_url_servico 9091)"

    cat > "$ACESSO" <<EOF
PORTA="9091"
URL="$URL_SERVICO"
EOF

fi

echo "Transmission configurado com sucesso."
