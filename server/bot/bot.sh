#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/bot/config.sh"

if [ "$TELEGRAM_ATIVO" != "true" ]; then
    echo "$(date) - Telegram Bot desativado pela configuração" >> "$SERVER/registros/telegram.log"
    exit 0
fi

source "$SERVER/bot/commands.sh"

API="https://api.telegram.org/bot${BOT_TOKEN}"

LOG="$SERVER/registros/telegram.log"

PID_FILE="$SERVER/estado/telegram.pid"
OFFSET_FILE="$SERVER/estado/telegram.offset"

if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")

    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo "$(date) - Bot já está rodando PID $OLD_PID" >> "$LOG"
        exit 0
    fi
fi

echo $$ > "$PID_FILE"

trap 'rm -f "$PID_FILE"' EXIT

if [ -f "$OFFSET_FILE" ]; then
    OFFSET=$(cat "$OFFSET_FILE")
else
    OFFSET=0
fi

echo "$(date) - Bot Telegram iniciado" >> "$LOG"


while true
do

    UPDATES=$(curl -s \
    "$API/getUpdates?timeout=30&offset=$OFFSET")


    echo "$UPDATES" | grep -q '"update_id"' || {
        sleep 2
        continue
    }


    UPDATE_ID=$(echo "$UPDATES" | grep -o '"update_id":[0-9]*' | head -1 | cut -d: -f2)


    CHAT_ID=$(echo "$UPDATES" | grep -o '"chat":{"id":[0-9]*' | head -1 | cut -d: -f3)


    TEXT=$(echo "$UPDATES" | grep -o '"text":"[^"]*"' | head -1 | cut -d'"' -f4)


    if [ -n "$UPDATE_ID" ]; then
        OFFSET=$((UPDATE_ID + 1))
        echo "$OFFSET" > "$OFFSET_FILE"
    fi


    if [ -n "$CHAT_ID" ] && [ -n "$TEXT" ]; then

        echo "$(date) - Mensagem recebida de $CHAT_ID: $TEXT" >> "$LOG"


        if [ "$CHAT_ID" != "$ADMIN_ID" ]; then
            echo "$(date) - Acesso negado para $CHAT_ID" >> "$LOG"
            send_message_chat "$CHAT_ID" "❌ Acesso não autorizado."
            continue
        fi

        process_command "$CHAT_ID" "$TEXT"

    fi


done
