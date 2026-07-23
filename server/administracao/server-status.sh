#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

CONFIG="$SERVER/configuracoes/identidade.conf"

if [ -f "$CONFIG" ]; then
    source "$CONFIG"
fi

echo "==============================="
echo "        SERVER STATUS"
echo "==============================="
echo "Data: $(date)"
echo

echo "=== SERVIÇOS ==="

check_service() {
    NAME="$1"
    PROCESS="$2"

    PID=$(pgrep -f "$PROCESS" | head -n1)

    if [ -n "$PID" ]; then
        echo "✓ $NAME (PID $PID)"
    else
        echo "✗ $NAME"
    fi
}

check_service "SSH" "sshd"
check_service "FileBrowser" "filebrowser --database"
check_service "Transmission" "transmission-daemon"
check_service "Jellyfin" "jellyfin"
check_service "Watchdog" "server/watchdog.sh"
check_service "Telegram Bot" "server/bot/bot.sh"
check_service "Dashboard Web" "python app.py"

echo

echo "=== DIRETÓRIOS ==="


check_directory() {
    NAME="$1"
    PATH_DIR="$2"

    if [ -d "$PATH_DIR" ]; then
        echo "✓ $NAME"
    else
        echo "✗ $NAME"
    fi
}

check_directory "Mídia Jellyfin" "$MIDIA"
check_directory "Downloads Transmission" "$DOWNLOADS"
check_directory "Configurações" "$SERVER/configuracoes"

echo

echo "=== TRANSMISSION ==="

if pgrep -f "transmission-daemon" > /dev/null; then
    echo "Status: ONLINE"
    transmission-remote -l
else
    echo "Status: OFFLINE"
fi

echo

echo "=== ARMAZENAMENTO ==="

df -h "$HOME" | awk 'NR==2 {
    print "Total: "$2;
    print "Usado: "$3;
    print "Livre: "$4;
    print "Uso: "$5
}'

echo

echo "=== ÚLTIMO BOOT ==="

tail -5 "$SERVER/registros/startup.log"

echo

echo "==============================="
