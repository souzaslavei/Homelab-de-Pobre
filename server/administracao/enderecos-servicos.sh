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

<<<<<<< HEAD

echo "=== REDE LOCAL ==="
echo


=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
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
<<<<<<< HEAD

=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
}


mostrar_servico "📁 File Browser" "$DATA/filebrowser/acesso.conf"

mostrar_servico "🎬 Jellyfin" "$DATA/jellyfin/acesso.conf"

mostrar_servico "⬇ Transmission" "$DATA/transmission/acesso.conf"

<<<<<<< HEAD

=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
echo "🖥 Dashboard Web"
echo "$(obter_url_servico 8088)"
echo

<<<<<<< HEAD


TS="$(obter_ip_tailscale)"


if [ -n "$TS" ]; then

echo "=== TAILSCALE ==="
echo


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


fi


=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
echo "Atualizado em:"
date "+%d/%m/%Y %H:%M"
