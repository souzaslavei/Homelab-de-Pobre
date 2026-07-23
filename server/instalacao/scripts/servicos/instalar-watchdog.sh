#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Instalador do Watchdog
# =====================================================

source "$HOME/server/instalacao/scripts/lib/instalador.sh"

WATCHDOG="$HOME/server/watchdog.sh"

registrar_log "Instalação do Watchdog iniciada"

mostrar_titulo "INSTALAÇÃO DO WATCHDOG"


mostrar_secao "Verificando Watchdog"

if [ -f "$WATCHDOG" ]; then
    mostrar_sucesso "watchdog.sh encontrado"
else
    mostrar_erro "watchdog.sh não encontrado"
    registrar_log "ERRO: watchdog.sh ausente"
    exit 1
fi


mostrar_secao "Verificando dependências"

if command -v termux-battery-status >/dev/null 2>&1; then
    mostrar_sucesso "Termux API disponível"
else
    mostrar_info "Termux API não encontrada"
fi


mostrar_secao "Preparando diretórios"

criar_diretorio "$HOME/server/registros"
criar_diretorio "$HOME/server/estado"

mostrar_sucesso "Diretórios preparados"


mostrar_secao "Aplicando permissões"

chmod +x "$WATCHDOG"

mostrar_sucesso "Permissão aplicada"


echo
mostrar_sucesso "Instalação do Watchdog concluída."

mostrar_info "O serviço será iniciado pelo startup.sh."


registrar_log "Instalação do Watchdog finalizada"
