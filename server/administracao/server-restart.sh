#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOG="$SERVER/registros/startup.log"

echo "$(date) - ===============================" >> "$LOG"
echo "$(date) - Iniciando restart do servidor" >> "$LOG"

echo "$(date) - Executando desligamento seguro" >> "$LOG"

"$SERVER/administracao/server-stop.sh"

echo "$(date) - Aguardando estabilização" >> "$LOG"

sleep 5

echo "$(date) - Iniciando servidor novamente" >> "$LOG"

"$SERVER/startup.sh"

echo "$(date) - Restart concluído" >> "$LOG"
echo "$(date) - ===============================" >> "$LOG"
