#!/data/data/com.termux/files/usr/bin/bash

LOG="$HOME/server/registros/startup.log"

source "$HOME/server/bot/config.sh"

mkdir -p "$HOME/server/registros"

mkdir -p "$HOME/server/estado"

echo "$(date) - Limpando arquivos PID antigos" >> "$LOG"
rm -f "$HOME/server/estado/"*.pid



echo "$(date) - ===============================" >> "$LOG"
echo "$(date) - Boot iniciado" >> "$LOG"

termux-wake-lock

echo "$(date) - Verificando SSH" >> "$LOG"

if pgrep -f "sshd" > /dev/null; then
    echo "$(date) - SSH já está ativo" >> "$LOG"
else
    echo "$(date) - Iniciando SSH" >> "$LOG"
    sshd
fi

sleep 3

echo "$(date) - Iniciando File Browser" >> "$LOG"
"$HOME/server/servicos/filebrowser.sh"

sleep 3

if pgrep -f "filebrowser --database" > /dev/null; then
    echo "$(date) - File Browser OK" >> "$LOG"
else
    echo "$(date) - ERRO: File Browser não iniciou" >> "$LOG"
fi


echo "$(date) - Iniciando Transmission" >> "$LOG"
"$HOME/server/servicos/transmission.sh"

sleep 3

if pgrep -f "transmission-daemon" > /dev/null; then
    PID=$(pgrep -f "transmission-daemon")
    echo "$(date) - Transmission OK (PID $PID)" >> "$LOG"
else
    echo "$(date) - ERRO: Transmission não iniciou" >> "$LOG"
fi


echo "$(date) - Iniciando Jellyfin" >> "$LOG"
"$HOME/server/servicos/jellyfin.sh"

sleep 5

if pgrep -f "/data/data/com.termux/files/usr/bin/jellyfin" > /dev/null; then
    PID=$(pgrep -f "/data/data/com.termux/files/usr/bin/jellyfin")
    echo "$(date) - Jellyfin OK (PID $PID)" >> "$LOG"
else
    echo "$(date) - ERRO: Jellyfin não iniciou" >> "$LOG"
fi


echo "$(date) - Iniciando Watchdog" >> "$LOG"

if pgrep -f "server/watchdog.sh" > /dev/null; then
    echo "$(date) - Watchdog já está ativo" >> "$LOG"
else
    nohup "$HOME/server/watchdog.sh" >> "$HOME/server/registros/watchdog-console.log" 2>&1 &
    echo "$(date) - Watchdog iniciado" >> "$LOG"
fi


echo "$(date) - Verificando Telegram Bot" >> "$LOG"

if [ "$TELEGRAM_ATIVO" = "true" ]; then

    if pgrep -f "server/bot/bot.sh" > /dev/null; then
        echo "$(date) - Telegram Bot já está ativo" >> "$LOG"
    else
        echo "$(date) - Iniciando Telegram Bot" >> "$LOG"

        nohup "$HOME/server/bot/bot.sh" \
        >> "$HOME/server/registros/telegram-console.log" 2>&1 &

        sleep 2

        if pgrep -f "server/bot/bot.sh" > /dev/null; then
            echo "$(date) - Telegram Bot OK" >> "$LOG"
        else
            echo "$(date) - ERRO: Telegram Bot não iniciou" >> "$LOG"
        fi
    fi

else

    echo "$(date) - Telegram Bot desativado pela configuração" >> "$LOG"

fi

echo "$(date) - Iniciando Dashboard Web" >> "$LOG"

"$HOME/server/servicos/web.sh"

sleep 2

if [ -f "$HOME/server/estado/web.pid" ]; then
    PID=$(cat "$HOME/server/estado/web.pid")

    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date) - Dashboard Web OK" >> "$LOG"
    else
        echo "$(date) - ERRO: Dashboard Web não iniciou" >> "$LOG"
    fi


fi

echo "$(date) - Boot concluído" >> "$LOG"
echo "$(date) - ===============================" >> "$LOG"
