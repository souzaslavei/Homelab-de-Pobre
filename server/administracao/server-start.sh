#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOG="$SERVER/registros/startup.log"

# Desativa modo manutenção
rm -f "$SERVER/estado/manutencao.flag"

echo "$(date) - ===============================" >> "$LOG"
echo "$(date) - Iniciando servidor manualmente" >> "$LOG"

"$SERVER/startup.sh"

echo "$(date) - Inicialização concluída" >> "$LOG"
echo "$(date) - ===============================" >> "$LOG"
