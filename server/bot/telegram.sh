#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/bot/config.sh"

API="https://api.telegram.org/bot${BOT_TOKEN}"


send_message()
{
    MESSAGE="$1"

    curl -s \
    -X POST "$API/sendMessage" \
    -d chat_id="$ADMIN_ID" \
    -d text="$MESSAGE" \
    >/dev/null
}


send_message_chat()
{
    CHAT_ID="$1"
    MESSAGE="$2"

    curl -s \
    -X POST "$API/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$MESSAGE" \
    >/dev/null
}

