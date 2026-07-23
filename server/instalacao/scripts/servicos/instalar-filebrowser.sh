#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Instalador do File Browser
# =====================================================

source "$HOME/server/instalacao/scripts/lib/instalador.sh"

registrar_log "Instalação do File Browser iniciada"

mostrar_titulo "INSTALAÇÃO DO FILE BROWSER"

if command -v filebrowser >/dev/null 2>&1; then

    mostrar_sucesso "File Browser encontrado"

else

    mostrar_info "Baixando File Browser..."

    TMPDIR="$PREFIX/tmp/filebrowser-install"

    rm -rf "$TMPDIR"
    mkdir -p "$TMPDIR"

    URL="https://github.com/filebrowser/filebrowser/releases/download/v2.63.18/linux-arm64-filebrowser.tar.gz"

    curl -L "$URL" -o "$TMPDIR/filebrowser.tar.gz" || exit 1

    tar -xzf "$TMPDIR/filebrowser.tar.gz" -C "$TMPDIR" || exit 1

    cp "$TMPDIR/filebrowser" "$PREFIX/bin/filebrowser" || exit 1

    chmod +x "$PREFIX/bin/filebrowser"

    rm -rf "$TMPDIR"

    if command -v filebrowser >/dev/null 2>&1; then
        mostrar_sucesso "File Browser instalado com sucesso"
    else
        mostrar_erro "Falha ao instalar File Browser"
        exit 1
    fi

fi

DB="$HOME/server/dados/filebrowser/filebrowser.db"
DADOS="$HOME/server/dados/filebrowser"

mostrar_secao "Preparando diretórios"

criar_diretorio "$DADOS"
criar_diretorio "$HOME/server/estado"
criar_diretorio "$HOME/server/registros"

mostrar_sucesso "Diretórios preparados"


mostrar_secao "Configuração do File Browser"


if [ -f "$DB" ]; then

    mostrar_info "Banco existente encontrado."
    mostrar_info "Mantendo usuários atuais."

    mostrar_status_servico \
    "FILE BROWSER JÁ CONFIGURADO" \
    "$(obter_url_servico 8080)" \
    "Já existem usuários configurados."

else

    mostrar_info "Primeira instalação detectada."

    SENHA=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 12)

    filebrowser config init     -d "$DB"     -a 0.0.0.0     -p 8080     -r "$HOME/storage/shared/"     >/dev/null 2>&1


    filebrowser users add admin "$SENHA"     --perm.admin     -d "$DB"


    URL_SERVICO="$(obter_url_servico 8080)"

    cat > "$DADOS/acesso.conf" <<EOF
USUARIO="admin"
SENHA="$SENHA"
PORTA="8080"
URL="$URL_SERVICO"
EOF


    mostrar_resumo_servico     "FILE BROWSER INSTALADO"     "$(obter_url_servico 8080)"     "admin"     "$SENHA"

fi


echo
mostrar_sucesso "Instalação concluída."

registrar_log "Instalação do File Browser finalizada"
