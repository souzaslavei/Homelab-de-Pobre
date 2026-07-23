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
<<<<<<< HEAD
    CHAT_ID=""
=======
    CHAT_ID="$1"
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
    MESSAGE="$2"

    curl -s \
    -X POST "$API/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$MESSAGE" \
    >/dev/null
}

