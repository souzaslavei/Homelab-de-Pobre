#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

cpu_uso() {
    CORES=$(nproc)

    top -bn1 | awk -v cores="$CORES" '
    /%cpu/ {
        for(i=1;i<=NF;i++){
            if($i ~ /idle/){
                idle=$i
                gsub(/[^0-9.]/,"",idle)

                if(idle > 100)
                    idle=idle/cores

                uso=100-idle

                if(uso < 0)
                    uso=0

                printf "%.0f", uso
                exit
            }
        }
    }'
}

memoria() {
    free -b | awk '
    /Mem:/ {
        total=$2
        usado=$3
        disponivel=$7
        printf "%.1f %.1f %.0f", usado/1024/1024/1024, total/1024/1024/1024, (usado/total)*100
    }'
}

swap() {
    free -b | awk '
    /Swap:/ {
        usado=$3
        total=$2
        printf "%.1f %.1f", usado/1024/1024/1024, total/1024/1024/1024
    }'
}

echo "==============================="
echo "     HARDWARE DO SERVIDOR"
echo "==============================="
echo

echo "📱 Dispositivo"
echo "• Modelo: $(getprop ro.product.model)"
echo "• Arquitetura: $(uname -m)"
echo

echo "⚙️ CPU"
echo "• Núcleos: $(nproc)"
echo "• Uso: $(cpu_uso)%"
echo

echo "🧠 Memória"

read RAM_USO RAM_TOTAL RAM_PERC <<< "$(memoria)"
echo "• RAM: ${RAM_USO} / ${RAM_TOTAL} GB (${RAM_PERC}%)"

RAM_DISP=$(free -b | awk '/Mem:/ {printf "%.1f", $7/1024/1024/1024}')
echo "• Disponível: ${RAM_DISP} GB"

read SWAP_USO SWAP_TOTAL <<< "$(swap)"
echo "• Swap: ${SWAP_USO} / ${SWAP_TOTAL} GB"
echo

echo "💾 Armazenamento"

df -h "$HOME" | awk 'NR==2 {
printf "• Livre: %s de %s (%s usado)\n", $4, $2, $5
}'
echo

echo "🔋 Bateria"

if command -v termux-battery-status >/dev/null; then
    BAT=$(termux-battery-status)

    echo "$BAT" | grep percentage | awk -F': ' '{gsub(/[,]/,"",$2); print "• "$2"%"}'
    echo "$BAT" | grep temperature | awk -F': ' '{gsub(/[,]/,"",$2); print "• Temperatura: "$2" °C"}'
    echo "$BAT" | grep status | awk -F': ' '{gsub(/[",]/,"",$2); if($2=="NOT_CHARGING") $2="Não carregando"; if($2=="CHARGING") $2="Carregando"; print "• Estado: "$2}'
    echo "$BAT" | grep health | awk -F': ' '{gsub(/[",]/,"",$2); if($2=="GOOD") $2="Boa"; print "• Saúde: "$2}'

else
    echo "• Termux API não disponível"
fi

echo

echo "📶 Rede"

if command -v termux-wifi-connectioninfo >/dev/null; then
    WIFI=$(termux-wifi-connectioninfo)

    echo "$WIFI" | grep '"ip"' | awk -F'"' '{print "• IP: "$4}'
    echo "$WIFI" | grep '"link_speed_mbps"' | awk -F': ' '{gsub(/,/,"",$2); print "• Link: "$2" Mbps"}'
    echo "$WIFI" | grep '"rssi"' | awk -F': ' '{gsub(/,/,"",$2); print "• Sinal: "$2" dBm"}'
else
    echo "• Termux API não disponível"
fi

echo

traduzir_tempo() {
    echo "$1" | sed \
    -e 's/years/anos/g' \
    -e 's/year/ano/g' \
    -e 's/months/meses/g' \
    -e 's/month/mês/g' \
    -e 's/weeks/semanas/g' \
    -e 's/week/semana/g' \
    -e 's/days/dias/g' \
    -e 's/day/dia/g' \
    -e 's/hours/horas/g' \
    -e 's/hour/hora/g' \
    -e 's/minutes/minutos/g' \
    -e 's/minute/minuto/g' \
    -e 's/seconds/segundos/g' \
    -e 's/second/segundo/g'
}

echo "🖥️ Sistema"

TEMPO=$(uptime -p 2>/dev/null | sed 's/up //')
echo "• Ligado há: $(traduzir_tempo "$TEMPO")"

echo "• Kernel: $(uname -r)"

echo
echo "==============================="
