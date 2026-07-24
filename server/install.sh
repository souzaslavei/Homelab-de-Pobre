#!/data/data/com.termux/files/usr/bin/bash

set -e

# Verifica se o instalador está sendo executado dentro da pasta server
if [ "$(basename "$PWD")" != "server" ]; then
    echo "Execute o instalador dentro da pasta server"
    exit 1
fi

PROJETO_DIR="$(cd "$(dirname "$0")" && pwd)"

# =====================================================
# Proteção contra queda de SSH usando tmux
# =====================================================

if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then

    SCRIPT_PATH="$(realpath "$0")"

    SSH_USER=$(whoami)

    SSH_IP=$(hostname -I 2>/dev/null | awk '{print $1}')

    if [ -z "$SSH_IP" ]; then
        SSH_IP="IP_DO_SERVIDOR"
    fi

    echo
    echo "=========================================="
    echo " INSTALAÇÃO VIA SSH DETECTADA"
    echo "=========================================="
    echo
    echo "A instalação será protegida usando tmux."
    echo
    echo "A conexão SSH pode cair durante esta etapa."
    echo "Isso é esperado."
    echo
    echo "Aguarde alguns segundos e conecte novamente:"
    echo
    echo "ssh $SSH_USER@$SSH_IP -p 8022"
    echo
    echo "Depois execute:"
    echo
    echo "tmux attach -t homelab-install"
    echo
    echo "=========================================="
    echo

    # Remove sessão anterior caso exista
    tmux kill-session -t homelab-install 2>/dev/null || true

    # Cria script auxiliar para execução protegida
    TMUX_SCRIPT="$PROJETO_DIR/estado/homelab-install-tmux.sh"

    cat > "$TMUX_SCRIPT" <<EOF
#!/data/data/com.termux/files/usr/bin/bash

bash "$SCRIPT_PATH"

echo
echo "=========================================="
echo "INSTALACAO ENCERRADA"
echo "=========================================="

echo
echo "Esta sessão será encerrada automaticamente em 10 segundos."
sleep 10
EOF

    chmod +x "$TMUX_SCRIPT"

    # Cria nova sessão protegida
    tmux new-session -d -s homelab-install "bash $TMUX_SCRIPT"

    echo "✓ Sessão protegida criada."
    echo
    echo "Encerrando conexão atual..."

    exit 0
fi


# =====================================================
# Homelab de Pobre
# Instalador Principal
# =====================================================

clear

echo "=========================================="
echo "        HOMELAB DE POBRE"
echo "=========================================="
echo
echo "Instalador Principal"
echo

BASE="$HOME/server"

VERSAO=$(grep "Versão:" "$BASE/VERSAO.txt" | awk "{print $2}")
SCRIPTS="$BASE/instalacao/scripts"

run_step() {

    NOME="$1"
    SCRIPT="$2"

    echo
    echo "→ $NOME"

    bash "$SCRIPT"

    RETORNO=$?

    if [ "$RETORNO" -ne 0 ]; then

        echo
        echo "✗ ERRO: $NOME falhou"
        echo "Script: $SCRIPT"
        echo "Código: $RETORNO"

        exit 1

    fi

    echo "✓ $NOME concluído"

}


check_script() {
    if [ ! -f "$1" ]; then
        echo "ERRO: Script não encontrado: $1"
        exit 1
    fi
}



if [ -f "$BASE/configuracoes/identidade.conf" ]; then
    echo "Configuração existente encontrada."
    read -p "Deseja continuar a instalação? (s/n): " CONTINUAR

    if [ "$CONTINUAR" != "s" ] && [ "$CONTINUAR" != "S" ]; then
        echo "Instalação cancelada."
        exit 0
    fi
fi


echo "Verificando arquivos de instalação..."

check_script "$SCRIPTS/verificar-ambiente.sh"
check_script "$SCRIPTS/preparar-termux.sh"
check_script "$SCRIPTS/criar-estrutura.sh"
check_script "$SCRIPTS/configurar-servidor.sh"
check_script "$SCRIPTS/servicos/instalar-filebrowser.sh"
check_script "$SCRIPTS/servicos/configurar-transmission.sh"
check_script "$SCRIPTS/servicos/instalar-jellyfin.sh"
check_script "$SCRIPTS/servicos/instalar-dashboard.sh"
check_script "$SCRIPTS/servicos/instalar-watchdog.sh"
check_script "$SCRIPTS/bot/configurar-telegram.sh"
check_script "$SCRIPTS/configurar-termux-boot.sh"

echo "✓ Todos os scripts encontrados"


echo "Iniciando instalação..."
echo

echo "================================="
echo "Etapa 1 - Verificando ambiente"
echo "================================="
bash "$SCRIPTS/verificar-ambiente.sh"

echo
echo "================================="
echo "Etapa 2 - Preparando Termux"
echo "================================="
bash "$SCRIPTS/preparar-termux.sh"

echo
echo "================================="
echo "Etapa 3 - Criando estrutura"
echo "================================="
bash "$SCRIPTS/criar-estrutura.sh"

echo
echo "================================="
echo "Etapa 4 - Configurando servidor"
echo "================================="
bash "$SCRIPTS/configurar-servidor.sh"

echo
echo "================================="
echo "Etapa 5 - Instalando serviços"
echo "================================="

run_step "Instalando File Browser" "$SCRIPTS/servicos/instalar-filebrowser.sh"

echo
run_step "Instalando Transmission" "$SCRIPTS/servicos/instalar-transmission.sh"

echo
run_step "Instalando Jellyfin" "$SCRIPTS/servicos/instalar-jellyfin.sh"

echo
run_step "Instalando Dashboard Web" "$SCRIPTS/servicos/instalar-dashboard.sh"

echo
run_step "Instalando Watchdog" "$SCRIPTS/servicos/instalar-watchdog.sh"

echo
echo "================================="
echo "Etapa 6 - Configurando Termux:Boot"
echo "================================="

run_step "Configurando Termux:Boot" "$SCRIPTS/configurar-termux-boot.sh"

echo
echo "================================="
echo "Etapa 7 - Configuração Telegram"
echo "================================="

run_step "Configurando Telegram Bot" "$SCRIPTS/bot/configurar-telegram.sh"

echo
echo "================================="
echo "Etapa 8 - Finalização"
echo "================================="

echo "Aplicando permissões..."

chmod +x "$BASE"/servicos/*.sh
chmod +x "$BASE"/administracao/*.sh
chmod +x "$BASE"/bot/*.sh
find "$BASE"/web/api -name "*.sh" -exec chmod +x {} \;
find "$BASE"/instalacao/scripts -name "*.sh" -exec chmod +x {} \;
chmod +x "$BASE"/watchdog.sh
chmod +x "$BASE"/startup.sh

echo
echo "Verificando servidor SSH..."

if ! pgrep sshd >/dev/null; then
    echo "Iniciando SSH..."
    sshd
    echo "✓ SSH iniciado"
else
    echo "✓ SSH já está ativo"
fi

echo "$(date) - Instalação concluída com sucesso" >> "$BASE/registros/instalacao.log"

cat > "$BASE/configuracoes/instalacao.conf" <<EOF
INSTALADO_EM="$(date)"
VERSAO="$VERSAO"
EOF


echo
echo "================================="
echo "Inicializando servidor"
echo "================================="

bash "$BASE/administracao/server-start.sh"

sleep 5

echo
echo "Servidor inicializado."

echo
echo "=========================================="
echo "SERVIDOR INICIADO COM SUCESSO"
echo "=========================================="

echo
bash "$BASE/administracao/enderecos-servicos.sh"

echo
echo "------------------------------------------"
echo "Credenciais do File Browser"
echo "------------------------------------------"

FILEBROWSER_CONF="$BASE/dados/filebrowser/acesso.conf"

if [ -f "$FILEBROWSER_CONF" ]; then
    source "$FILEBROWSER_CONF"

    echo "Usuário: ${USUARIO:-admin}"
    echo "Senha : ${SENHA:-admin}"
else
    echo "Arquivo de configuração não encontrado."
fi

echo
echo "------------------------------------------"
echo "Jellyfin"
echo "------------------------------------------"
echo "O Jellyfin será configurado no primeiro acesso através do assistente inicial."

echo
echo "------------------------------------------"
echo "Transmission"
echo "------------------------------------------"
echo "O Transmission pode ser acessado pelo Painel de Controle."

echo
echo "Serviços instalados:"
echo
echo "=========================================="
echo "Instalação finalizada."
echo "Homelab de Pobre pronto para uso."
echo "Versão instalada: $VERSAO"
echo "=========================================="
