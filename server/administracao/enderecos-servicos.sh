#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Lista de endereços dos serviços
# =====================================================

SERVER="$HOME/server"
DATA="$SERVER/dados"

source "$SERVER/instalacao/scripts/lib/instalador.sh"

echo "================================="
echo " 🌐 ENDEREÇOS DO HOMELAB"
echo "================================="
echo


echo "=== REDE LOCAL ==="
echo


mostrar_servico() {

    NOME="$1"
    ARQUIVO="$2"

    if [ -f "$ARQUIVO" ]; then

        source "$ARQUIVO"

        IP=$(obter_ip_local)

        echo "$NOME"
        echo "http://$IP:$PORTA"
        echo

    else

        echo "$NOME"
        echo "Não configurado"
        echo

    fi

}


mostrar_servico "📁 File Browser" "$DATA/filebrowser/acesso.conf"

mostrar_servico "🎬 Jellyfin" "$DATA/jellyfin/acesso.conf"

mostrar_servico "⬇ Transmission" "$DATA/transmission/acesso.conf"


echo "🖥 Dashboard Web"
echo "$(obter_url_servico 8088)"
echo



TS="$(obter_ip_tailscale)"


echo "=== TAILSCALE ==="
echo

if [ -n "$TS" ]; then

echo "📁 File Browser"
echo "$(obter_url_servico_tailscale 8080)"
echo


echo "🎬 Jellyfin"
echo "$(obter_url_servico_tailscale 8096)"
echo


echo "⬇ Transmission"
echo "$(obter_url_servico_tailscale 9091)"
echo


echo "🖥 Dashboard Web"
echo "$(obter_url_servico_tailscale 8088)"
echo


else

echo "Tailscale desligado ou sem conexão"

fi


echo "Atualizado em:"
date "+%d/%m/%Y %H:%M"
