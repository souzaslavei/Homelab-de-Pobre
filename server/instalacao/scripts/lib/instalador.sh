#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Biblioteca do Instalador
# =====================================================

LOG="$HOME/server/registros/instalacao.log"

registrar_log() {
    echo "$(date) - $1" >> "$LOG"
}

mostrar_titulo() {

    echo "================================="
    echo " $1"
    echo "================================="
    echo

}

mostrar_sucesso() {
    echo "✓ $1"
}

mostrar_erro() {
    echo "✗ $1"
}

mostrar_info() {
    echo "$1"
}

mostrar_secao() {
    echo
    echo "================================="
    echo " $1"
    echo "================================="
}

mostrar_aviso() {
    echo "⚠ $1"
}

mostrar_progresso() {
    echo
    echo "---------------------------------"
    echo "$1"
    echo "---------------------------------"
}

mostrar_resumo_servico() {
    echo
    echo "================================="
    echo " $1"
    echo "================================="
    echo "URL.............: $2"
    echo "Usuário.........: $3"
    echo "Senha...........: $4"
    echo
    echo "⚠ Altere a senha no primeiro acesso."
}


mostrar_status_servico() {
    echo
    echo "================================="
    echo " $1"
    echo "================================="
    echo
    echo "Endereço:"
    echo "$2"
    echo
    echo "Usuários:"
    echo "$3"
    echo
    echo "⚠ As credenciais já foram definidas anteriormente."
}


mostrar_info_servico() {
    echo
    echo "================================="
    echo " $1"
    echo "================================="
    echo
    echo "Endereço:"
    echo "$2"
    echo
    echo "$3"
}



obter_ip_local() {

    IP=$(ifconfig 2>/dev/null | awk '

        /^wlan0:/ {wifi=1; next}

        wifi && /inet / {
            print $2
            exit
        }

    ')

    [ -z "$IP" ] && IP="127.0.0.1"

    echo "$IP"

}


obter_ip_tailscale() {

    IP=$(ifconfig 2>/dev/null | awk '

        /^tun0:/ {tun=1; next}

        tun && /inet / {
            print $2
            exit
        }

    ')

    echo "$IP"

}


obter_url_servico() {

    PORTA="$1"

    echo "http://$(obter_ip_local):$PORTA"

}


obter_url_servico_tailscale() {

    PORTA="$1"

    TS=$(obter_ip_tailscale)

    [ -z "$TS" ] && return

    echo "http://$TS:$PORTA"

}


criar_diretorio() {

    mkdir -p "$1"

}

verificar_pacote() {

    command -v "$1" >/dev/null 2>&1

}

instalar_pacote() {

    PACOTE="$1"
    COMANDO="$2"

    mostrar_info "Verificando $PACOTE..."

    if verificar_pacote "$COMANDO"
    then

        mostrar_sucesso "$PACOTE já instalado"
        registrar_log "$PACOTE já instalado"

        return 0

    fi

    mostrar_info "Instalando $PACOTE..."

    pkg install "$PACOTE" -y >> "$LOG" 2>&1

    if verificar_pacote "$COMANDO"
    then

        mostrar_sucesso "$PACOTE instalado"
        registrar_log "$PACOTE instalado"

    else

        mostrar_erro "Falha ao instalar $PACOTE"
        registrar_log "ERRO instalação $PACOTE"

        return 1

    fi

}
