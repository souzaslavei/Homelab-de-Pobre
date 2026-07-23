#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/web/config.sh"

echo "SERVER_NAME=$SERVER_NAME"

if pgrep sshd >/dev/null; then
    echo "SSH=ONLINE"
else
    echo "SSH=OFFLINE"
fi


if [ -f "$SERVER/estado/filebrowser.pid" ]; then
    PID=$(cat "$SERVER/estado/filebrowser.pid")

    if ps -p "$PID" >/dev/null; then
        echo "FILEBROWSER=ONLINE"
        echo "FILEBROWSER_PID=$PID"
    else
        echo "FILEBROWSER=OFFLINE"
    fi
else
    echo "FILEBROWSER=OFFLINE"
fi


if [ -f "$SERVER/estado/transmission.pid" ]; then
    PID=$(cat "$SERVER/estado/transmission.pid")

    if ps -p "$PID" >/dev/null; then
        echo "TRANSMISSION=ONLINE"
        echo "TRANSMISSION_PID=$PID"
    else
        echo "TRANSMISSION=OFFLINE"
    fi
else
    echo "TRANSMISSION=OFFLINE"
fi


if [ -f "$SERVER/estado/jellyfin.pid" ]; then
    PID=$(cat "$SERVER/estado/jellyfin.pid")

    if ps -p "$PID" >/dev/null; then
        echo "JELLYFIN=ONLINE"
        echo "JELLYFIN_PID=$PID"
    else
        echo "JELLYFIN=OFFLINE"
    fi
else
    echo "JELLYFIN=OFFLINE"
fi



if [ -f "$SERVER/estado/web.pid" ]; then

    PID=$(cat "$SERVER/estado/web.pid")

    if ps -p "$PID" >/dev/null; then
        echo "WEB=ONLINE"
        echo "WEB_PID=$PID"

    elif curl -s http://127.0.0.1:8088 >/dev/null 2>&1; then
        echo "WEB=ONLINE"
        echo "WEB_PID=detectado"

    else
        echo "WEB=OFFLINE"
    fi

elif curl -s http://127.0.0.1:8088 >/dev/null 2>&1; then

    echo "WEB=ONLINE"
    echo "WEB_PID=detectado"

else

    echo "WEB=OFFLINE"

fi

format_uptime() {

    UPTIME=$(uptime -p | cut -c 4-)

    UPTIME=$(echo "$UPTIME" \
    | sed 's/years/anos/g' \
    | sed 's/year/ano/g' \
    | sed 's/months/meses/g' \
    | sed 's/month/mês/g' \
    | sed 's/weeks/semanas/g' \
    | sed 's/week/semana/g' \
    | sed 's/days/dias/g' \
    | sed 's/day/dia/g' \
    | sed 's/hours/horas/g' \
    | sed 's/hour/hora/g' \
    | sed 's/minutes/minutos/g' \
    | sed 's/minute/minuto/g' \
    | sed 's/seconds/segundos/g' \
    | sed 's/second/segundo/g' \
    | sed 's/,/ e/g')

    echo "$UPTIME"
}


echo "UPTIME=Tempo ligado: $(format_uptime)"

echo "UPDATED=Atualizado em $(date '+%d/%m/%Y às %H:%M:%S')"
