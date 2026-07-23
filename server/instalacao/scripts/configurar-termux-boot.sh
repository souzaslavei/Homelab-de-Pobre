#!/data/data/com.termux/files/usr/bin/bash

LOG="$HOME/server/registros/instalacao.log"

mkdir -p "$HOME/server/registros"

BOOT_DIR="$HOME/.termux/boot"
BOOT_SCRIPT="$BOOT_DIR/start-server"

echo "$(date) - Verificando Termux:Boot" >> "$LOG"

echo "================================="
echo " CONFIGURAÇÃO TERMUX:BOOT"
echo " Homelab de Pobre"
echo "================================="
echo

if [ ! -d "$BOOT_DIR" ]; then
    echo "Criando diretório Termux:Boot..."
    mkdir -p "$BOOT_DIR"
fi


if [ -f "$BOOT_SCRIPT" ]; then

    echo "✓ Configuração de boot encontrada:"
    echo "$BOOT_SCRIPT"
    echo
    echo "Nenhuma alteração realizada."
    echo "Arquivo existente preservado."

    echo "$(date) - Termux:Boot existente preservado" >> "$LOG"

else

    echo "Criando configuração de inicialização..."

    cat > "$BOOT_SCRIPT" <<'EOF_BOOT'
#!/data/data/com.termux/files/usr/bin/bash

termux-wake-lock

sleep 5

"$HOME/server/startup.sh"
EOF_BOOT

    chmod +x "$BOOT_SCRIPT"

    echo "✓ Termux:Boot configurado"
    echo "$(date) - Termux:Boot criado" >> "$LOG"

fi

echo
echo "Configuração concluída."
