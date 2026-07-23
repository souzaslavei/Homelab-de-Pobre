#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Configurador do Telegram Bot
# =====================================================

SERVER="$HOME/server"
CONFIG="$SERVER/bot/config.sh"
LOG="$SERVER/registros/instalacao.log"

mkdir -p "$SERVER/registros"

echo "================================="
echo " CONFIGURAÇÃO DO TELEGRAM BOT"
echo "================================="
echo

read -p "Deseja ativar o bot Telegram? (s/n): " RESPOSTA

if [ "$RESPOSTA" = "s" ] || [ "$RESPOSTA" = "S" ]; then

    echo
    echo "Para obter o Token:"
    echo "- Crie um bot pelo BotFather no Telegram"
    echo "- Copie o token fornecido"
    echo

    read -p "Token do bot: " BOT_TOKEN

    echo
    echo "O ID administrador é o seu ID numérico do Telegram."
    echo "Ele define quem pode controlar o servidor pelo bot."
    echo

    read -p "ID administrador: " ADMIN_ID

    cat > "$CONFIG" <<EOF_CONFIG
#!/data/data/com.termux/files/usr/bin/bash

# Configuração do Telegram Bot
# Gerado pelo instalador do Homelab de Pobre

TELEGRAM_ATIVO=true

BOT_TOKEN="$BOT_TOKEN"
ADMIN_ID="$ADMIN_ID"
EOF_CONFIG

    chmod 600 "$CONFIG"

    echo
    echo "✓ Telegram Bot ativado"

else

    cat > "$CONFIG" <<EOF_CONFIG
#!/data/data/com.termux/files/usr/bin/bash

# Configuração do Telegram Bot
# Gerado pelo instalador do Homelab de Pobre

TELEGRAM_ATIVO=false

BOT_TOKEN=""
ADMIN_ID=""
EOF_CONFIG

    chmod 600 "$CONFIG"

    echo
    echo "✓ Telegram Bot desativado"

fi

echo "$(date) - Configuração do Telegram concluída" >> "$LOG"

echo
echo "✓ Configuração salva em:"
echo "$CONFIG"
