#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Instalador do Jellyfin
# =====================================================

source "$HOME/server/instalacao/scripts/lib/instalador.sh"

registrar_log "Instalação do Jellyfin iniciada"

mostrar_titulo "INSTALAÇÃO DO JELLYFIN"

if command -v jellyfin >/dev/null 2>&1; then
    mostrar_sucesso "Jellyfin encontrado"
else
    mostrar_info "Instalando Jellyfin..."
    instalar_pacote "jellyfin-server" "jellyfin" || exit 1
fi

mostrar_secao "Preparando diretórios"

criar_diretorio "$HOME/server/registros"
criar_diretorio "$HOME/server/estado"
criar_diretorio "$HOME/server/dados/jellyfin"

mostrar_sucesso "Diretórios preparados"

mostrar_secao "Configuração"

ACESSO="$HOME/server/dados/jellyfin/acesso.conf"

if [ -f "$ACESSO" ]; then

    mostrar_info_servico \
    "JELLYFIN JÁ CONFIGURADO" \
    "$(obter_url_servico 8096)" \
    "Mantendo configurações existentes."

else

    URL_SERVICO="$(obter_url_servico 8096)"

    cat > "$ACESSO" <<EOF
PORTA="8096"
URL="$URL_SERVICO"
EOF

    mostrar_info_servico \
    "JELLYFIN INSTALADO" \
    "$URL_SERVICO" \
    "Primeiro acesso: crie o usuário administrador pelo assistente do Jellyfin."

fi

echo
mostrar_sucesso "Instalação concluída."

registrar_log "Instalação do Jellyfin finalizada"

mostrar_secao "Configurando ambiente .NET"

if ! grep -q DOTNET_ROOT ~/.bashrc 2>/dev/null; then
cat >> ~/.bashrc <<EOL

export DOTNET_ROOT=/data/data/com.termux/files/usr/lib/dotnet
export PATH=\$DOTNET_ROOT:\$PATH

EOL
fi
