#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
CONFIG="$SERVER/configuracoes/identidade.conf"
LOG="$SERVER/registros/instalacao.log"

mkdir -p "$SERVER/configuracoes"
mkdir -p "$SERVER/registros"

echo "$(date) - Configuração inicial iniciada" >> "$LOG"

echo "================================="
echo " CONFIGURAÇÃO DO SERVIDOR"
echo " Homelab de Pobre"
echo "================================="
echo

if [ -f "$CONFIG" ]; then

    echo "⚠ Configuração existente encontrada."

    read -p "Deseja criar uma nova configuração? (s/n): " CONFIRMAR

    if [ "$CONFIRMAR" != "s" ]; then
        echo "Operação cancelada."
        exit 0
    fi

    cp "$CONFIG" "$SERVER/backup/identidade.conf.$(date +%Y%m%d-%H%M%S)"

fi


echo
echo "Nome do servidor"
echo "Será o nome mostrado no painel e nas mensagens do bot."
echo "Exemplo: Servidor-Casa"
echo "Pressione Enter para usar: Homelab"
read -p "Nome do servidor: " NOME_SERVIDOR

if [ -z "$NOME_SERVIDOR" ]; then
    NOME_SERVIDOR="Homelab"
fi

echo
echo "Identificação do dispositivo"
echo "Nome usado para identificar este aparelho na rede."
echo "Exemplo: Celular-Principal"
read -p "Identificação: " IDENTIFICACAO

if [ -z "$IDENTIFICACAO" ]; then
    IDENTIFICACAO="Dispositivo-Android"
fi

echo
echo "Pasta de mídias"
echo "Local dos filmes, séries e animes usados pelo Jellyfin."
echo "Padrão recomendado:"
echo "/storage/emulated/0/Home/Midia"
echo "Pressione Enter para usar o padrão."
read -p "Caminho das mídias: " MIDIA

if [ -z "$MIDIA" ]; then
    MIDIA="/storage/emulated/0/Home/Midia"
fi

echo
echo "Pasta de downloads"
echo "Local onde o Transmission salva os arquivos baixados."
echo "Padrão recomendado:"
echo "/storage/emulated/0/Home/Downloads"
echo "Pressione Enter para usar o padrão."
read -p "Caminho dos downloads: " DOWNLOADS

if [ -z "$DOWNLOADS" ]; then
    DOWNLOADS="/storage/emulated/0/Home/Downloads"
fi


echo
echo "================================="
echo " RESUMO DA CONFIGURAÇÃO"
echo "================================="
echo
echo "Servidor........: $NOME_SERVIDOR"
echo "Identificação...: $IDENTIFICACAO"
echo "Mídias..........: $MIDIA"
echo "Downloads.......: $DOWNLOADS"
echo
read -p "Confirmar configuração? (s/n): " CONFIRMAR

if [ "$CONFIRMAR" != "s" ] && [ "$CONFIRMAR" != "S" ]; then
    echo
    echo "Configuração cancelada."
    exit 0
fi

cat > "$CONFIG" <<EOF_CONFIG
# =====================================================
# Homelab de Pobre
# Configuração do Servidor
# Gerado automaticamente pelo instalador
# =====================================================

NOME_SERVIDOR="$NOME_SERVIDOR"
IDENTIFICACAO="$IDENTIFICACAO"

MIDIA="$MIDIA"
DOWNLOADS="$DOWNLOADS"

<<<<<<< HEAD
VERSAO="4.0.1"
=======
VERSAO="3.1"
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
PLATAFORMA="Android + Termux"
EOF_CONFIG

mkdir -p "$MIDIA"
mkdir -p "$DOWNLOADS"
mkdir -p "$DOWNLOADS/concluidos"
mkdir -p "$DOWNLOADS/temporarios"

echo
echo "✓ Configuração criada:"
echo "$CONFIG"

echo "$(date) - Configuração inicial concluída" >> "$LOG"
