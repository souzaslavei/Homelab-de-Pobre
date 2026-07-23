#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

<<<<<<< HEAD
LOCK="$SERVER/estado/watchdog.pid"

mkdir -p "$SERVER/estado"

if [ -f "$LOCK" ]; then

    PID=$(cat "$LOCK")

    if kill -0 "$PID" 2>/dev/null; then
        exit 0
    fi

fi

echo $$ > "$LOCK"

=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
source "$SERVER/bot/config.sh"
source "$SERVER/bot/telegram.sh"

LOG="$SERVER/registros/watchdog.log"
ALERTLOG="$SERVER/registros/alerts.log"

mkdir -p "$SERVER/registros"


alert()
{
    ALERT_TIME=$(date "+%d/%m/%Y %H:%M:%S")

    echo "$ALERT_TIME - ALERTA: $1" >> "$ALERTLOG"

    send_message "🚨 ALERTA DO SERVIDOR

🕒 Horário: $ALERT_TIME

📌 Evento:
$1

🤖 Origem: Watchdog"
}

resource_check()
{
    # RAM
    RAM=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

    if [ "$RAM" -ge 90 ]; then
        alert "Uso de RAM alto: ${RAM}%"
    fi


    # Armazenamento
    DISK=$(df "$HOME" | awk 'NR==2 {gsub("%","",$5); print $5}')

    if [ "$DISK" -ge 85 ]; then
        alert "Armazenamento cheio: ${DISK}% usado"
    fi


    # Bateria
    if command -v termux-battery-status >/dev/null; then
        BAT=$(termux-battery-status | grep percentage | awk -F': ' '{gsub(/[,]/,"",$2); print $2}')

        if [ "$BAT" -le 20 ]; then
            alert "Bateria baixa: ${BAT}%"
        fi
    fi
}


log_cleanup()
{
    LAST="$SERVER/estado/log-cleanup.last"
    NOW=$(date +%s)

    if [ ! -f "$LAST" ]; then
        echo "$NOW" > "$LAST"
        "$SERVER/administracao/log-cleanup.sh"
        return
    fi

    OLD=$(cat "$LAST")
    DIFF=$((NOW - OLD))

    if [ "$DIFF" -ge 86400 ]; then
        echo "$NOW" > "$LAST"
        "$SERVER/administracao/log-cleanup.sh"
    fi
}




check_service()
{
    NAME="$1"
    PIDFILE="$2"
    PROCESS="$3"
    START="$4"

    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")

        if kill -0 "$PID" 2>/dev/null; then
            echo "$(date) - $NAME OK (PID $PID)" >> "$LOG"
            return
        fi
    fi

    if pgrep -f "$PROCESS" >/dev/null; then
        PID=$(pgrep -f "$PROCESS" | head -n1)
        echo "$PID" > "$PIDFILE"
        echo "$(date) - $NAME recuperado (PID $PID)" >> "$LOG"
        return
    fi

    echo "$(date) - $NAME caiu, reiniciando" >> "$LOG"
    alert "$NAME caiu e foi reiniciado"
    "$START"
}

echo "$(date) - Watchdog iniciado" >> "$LOG"

START_TIME=$(date +%s)


while true

do

    UPTIME=$(( $(date +%s) - START_TIME ))

    if [ "$UPTIME" -lt 120 ]; then
        echo "$(date) - Aguardando inicialização dos serviços ($UPTIME/120s)" >> "$LOG"
        sleep 30
        continue
    fi

    if [ -f "$SERVER/estado/manutencao.flag" ]; then
        echo "$(date) - Servidor em manutenção, ignorando verificação" >> "$LOG"
        sleep 300
        continue
    fi


    echo "$(date) - Verificando serviços" >> "$LOG"

    resource_check
    log_cleanup


    # SSH
    if pgrep -f "sshd" > /dev/null; then
        echo "$(date) - SSH OK" >> "$LOG"
    else
        echo "$(date) - SSH caiu, iniciando" >> "$LOG"
        alert "SSH estava parado e foi iniciado"
        sshd
    fi


    # File Browser
    check_service \
    "File Browser" \
    "$SERVER/estado/filebrowser.pid" \
    "filebrowser --database" \
    "$SERVER/servicos/filebrowser.sh"


    # Transmission
    check_service \
    "Transmission" \
    "$SERVER/estado/transmission.pid" \
    "transmission-daemon" \
    "$SERVER/servicos/transmission.sh"


    # Jellyfin
    check_service \
    "Jellyfin" \
    "$SERVER/estado/jellyfin.pid" \
    "jellyfin" \
    "$SERVER/servicos/jellyfin.sh"


    # Dashboard Web
    check_service \
    "Dashboard Web" \
    "$SERVER/estado/web.pid" \
    "python app.py" \
    "$SERVER/servicos/web.sh"


    # Telegram Bot
    if pgrep -f "server/bot/bot.sh" > /dev/null; then
        echo "$(date) - Telegram Bot OK" >> "$LOG"
    else
        echo "$(date) - Telegram Bot caiu, reiniciando" >> "$LOG"
        alert "Telegram Bot caiu e foi reiniciado"

        nohup bash "$SERVER/bot/bot.sh" \
        >> "$SERVER/registros/telegram-console.log" 2>&1 &

        sleep 2

        if pgrep -f "server/bot/bot.sh" > /dev/null; then
            echo "$(date) - Telegram Bot reiniciado com sucesso" >> "$LOG"
        else
            echo "$(date) - ERRO: Telegram Bot não iniciou" >> "$LOG"
        fi
    fi

    sleep 300

done
