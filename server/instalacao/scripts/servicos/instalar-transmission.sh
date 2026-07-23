#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Instalador do Transmission
# =====================================================

source "$HOME/server/instalacao/scripts/lib/instalador.sh"

registrar_log "Instalação do Transmission iniciada"

mostrar_titulo "INSTALAÇÃO DO TRANSMISSION"

if command -v transmission-daemon >/dev/null 2>&1; then
    mostrar_sucesso "Transmission encontrado"
else
    mostrar_info "Instalando Transmission..."
    instalar_pacote "transmission" "transmission-daemon" || exit 1
fi

mostrar_secao "Preparando diretórios"

criar_diretorio "$HOME/server/dados/transmission"
criar_diretorio "$HOME/server/registros"
criar_diretorio "$HOME/server/estado"

mostrar_sucesso "Diretórios preparados"

mostrar_secao "Configuração"

ACESSO="$HOME/server/dados/transmission/acesso.conf"

if [ -f "$ACESSO" ]; then

    mostrar_info "Configuração de acesso já existente."

    mostrar_info_servico \
    "TRANSMISSION JÁ CONFIGURADO" \
    "$(obter_url_servico 9091)" \
    "Mantendo configurações existentes."

else

    URL_SERVICO="$(obter_url_servico 9091)"

    cat > "$ACESSO" <<EOF
PORTA="9091"
URL="$URL_SERVICO"
EOF

    mostrar_info_servico \
    "TRANSMISSION INSTALADO" \
    "$URL_SERVICO" \
    "Serviço pronto para uso."

fi

mostrar_info "Aplicando configuração do Transmission..."

bash "$HOME/server/instalacao/scripts/servicos/configurar-transmission.sh"

echo
mostrar_sucesso "Instalação concluída."

registrar_log "Instalação do Transmission finalizada"
