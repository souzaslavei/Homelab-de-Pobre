#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/configuracoes/identidade.conf"

echo "DEVICE=$NOME_SERVIDOR"


MEM=$(free -m)

RAM_TOTAL=$(echo "$MEM" | awk '/Mem:/ {print $2}')
RAM_USED=$(echo "$MEM" | awk '/Mem:/ {print $3}')
RAM_AVAILABLE=$(echo "$MEM" | awk '/Mem:/ {print $7}')

SWAP_TOTAL=$(echo "$MEM" | awk '/Swap:/ {print $2}')
SWAP_USED=$(echo "$MEM" | awk '/Swap:/ {print $3}')

RAM_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))


echo "RAM_TOTAL=${RAM_TOTAL}MB"
echo "RAM_USED=${RAM_USED}MB"
echo "RAM_AVAILABLE=${RAM_AVAILABLE}MB"
echo "RAM_PERCENT=${RAM_PERCENT}%"

echo "SWAP_TOTAL=${SWAP_TOTAL}MB"
echo "SWAP_USED=${SWAP_USED}MB"


STORAGE=$(df -k /storage/emulated/0 | awk 'NR==2')

STORAGE_TOTAL=$(echo "$STORAGE" | awk '{print $2}')
STORAGE_USED=$(echo "$STORAGE" | awk '{print $3}')
STORAGE_AVAILABLE=$(echo "$STORAGE" | awk '{print $4}')
STORAGE_PERCENT=$(echo "$STORAGE" | awk '{print $5}')


echo "STORAGE_TOTAL=$((STORAGE_TOTAL / 1048576))GB"
echo "STORAGE_USED=$((STORAGE_USED / 1048576))GB"
echo "STORAGE_AVAILABLE=$((STORAGE_AVAILABLE / 1048576))GB"
echo "STORAGE_PERCENT=${STORAGE_PERCENT}"




BATTERY=$(termux-battery-status)


CPU_CORES=$(nproc)

CPU_USAGE=$(top -b -n 1 | grep "%cpu" | head -1 | awk '{print $5}')

CPU_USAGE=$(echo "$CPU_USAGE" | awk '{print 100 - ($1 / 8)}')

CPU_USAGE=${CPU_USAGE%.*}

echo "CPU_CORES=${CPU_CORES}"
echo "CPU_USAGE=${CPU_USAGE}%"


BATTERY_LEVEL=$(echo "$BATTERY" | grep percentage | sed 's/[^0-9]//g')

TEMPERATURE=$(echo "$BATTERY" | grep temperature | sed 's/[^0-9.]//g')

PLUGGED=$(echo "$BATTERY" | grep plugged | cut -d '"' -f4)


case "$PLUGGED" in
    "PLUGGED_AC"|"AC")
        PLUGGED="Carregando"
        ;;
    "UNPLUGGED")
        PLUGGED="Desconectado"
        ;;
    *)
        PLUGGED="Desconhecido"
        ;;
esac


echo "BATTERY=${BATTERY_LEVEL}%"
echo "TEMPERATURE=${TEMPERATURE}°C"
echo "PLUGGED=${PLUGGED}"
