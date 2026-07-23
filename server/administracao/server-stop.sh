#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOG="$SERVER/registros/startup.log"

# Ativa modo manutenção para o watchdog
touch "$SERVER/estado/manutencao.flag"

mkdir -p "$SERVER/registros"

echo "$(date) - ===============================" >> "$LOG"
echo "$(date) - Iniciando desligamento" >> "$LOG"


stop_pidfile(){

NAME="$1"
FILE="$2"

if [ -f "$FILE" ]; then

PID=$(cat "$FILE")

if kill -0 "$PID" 2>/dev/null; then

echo "$(date) - Parando $NAME PID $PID" >> "$LOG"

kill "$PID"

sleep 5

if kill -0 "$PID" 2>/dev/null; then
kill -9 "$PID"
echo "$(date) - $NAME forçado" >> "$LOG"
else
echo "$(date) - $NAME encerrado" >> "$LOG"
fi

else
echo "$(date) - $NAME já parado" >> "$LOG"
fi

rm -f "$FILE"

else
echo "$(date) - PID $NAME não encontrado" >> "$LOG"
fi

}


stop_pidfile "Dashboard Web" "$SERVER/estado/web.pid"

stop_pidfile "FileBrowser" "$SERVER/estado/filebrowser.pid"

stop_pidfile "Jellyfin" "$SERVER/estado/jellyfin.pid"

# Garantia extra: encerra Jellyfin caso PID file esteja desatualizado
if pgrep -x jellyfin >/dev/null; then
    echo "$(date) - Jellyfin encontrado após stop, encerrando processo restante" >> "$LOG"
    pkill -x jellyfin
    sleep 3
fi


if pgrep -f transmission-daemon >/dev/null; then

echo "$(date) - Parando Transmission" >> "$LOG"

transmission-remote --exit >> "$LOG" 2>&1

sleep 5

fi


<<<<<<< HEAD

echo "$(date) - Parando Watchdog" >> "$LOG"

pkill -f "server/watchdog.sh"

rm -f "$SERVER/estado/watchdog.pid"

=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
echo "$(date) - Servidor desligado" >> "$LOG"
echo "$(date) - ===============================" >> "$LOG"

