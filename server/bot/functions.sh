#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/configuracoes/identidade.conf"


server_status()
{
    MSG="🟢 Status do servidor\n\n"

    if pgrep -f "sshd" > /dev/null; then
        MSG+="SSH: ✅ Online\n"
    else
        MSG+="SSH: ❌ Offline\n"
    fi


    check_status()
    {
        NAME="$1"
        PIDFILE="$2"

        if [ -f "$PIDFILE" ]; then
            PID=$(cat "$PIDFILE")

            if kill -0 "$PID" 2>/dev/null; then
                MSG+="$NAME: ✅ Online (PID $PID)\n"
            else
                MSG+="$NAME: ❌ Offline\n"
            fi
        else
            MSG+="$NAME: ❌ Offline\n"
        fi
    }


    check_status "File Browser" "$SERVER/estado/filebrowser.pid"
    check_status "Transmission" "$SERVER/estado/transmission.pid"
    check_status "Jellyfin" "$SERVER/estado/jellyfin.pid"
    check_status "Dashboard Web" "$SERVER/estado/web.pid"


    UPTIME=$(uptime -p 2>/dev/null | sed "s/up //; s/years/anos/g; s/year/ano/g; s/months/meses/g; s/month/mês/g; s/weeks/semanas/g; s/week/semana/g; s/days/dias/g; s/day/dia/g; s/hours/horas/g; s/hour/hora/g; s/minutes/minutos/g; s/minute/minuto/g; s/seconds/segundos/g; s/second/segundo/g")

    MSG+="\n⏱ Tempo ativo: $UPTIME"

    echo -e "$MSG"
}



hardware_status()
{
    "$SERVER/administracao/server-hardware.sh"
}


enderecos_status()
{
    "$SERVER/administracao/enderecos-servicos.sh"
}



logs_status()
{
    echo "📋 Últimos logs"
    echo

    echo "🛡 Watchdog:"
    tail -5 "$SERVER/registros/watchdog.log"

    echo

    echo "🤖 Telegram:"
    tail -5 "$SERVER/registros/telegram.log"

    echo

    echo "🚨 Alertas:"
    tail -5 "$SERVER/registros/alerts.log"
}



services_status()
{
    echo "⚙️ Serviços"
    echo

    if pgrep -f "sshd" > /dev/null; then
        echo "SSH: ✅ Online"
    else
        echo "SSH: ❌ Offline"
    fi


    if [ -f "$SERVER/estado/filebrowser.pid" ]; then
        PID=$(cat "$SERVER/estado/filebrowser.pid")

        if kill -0 "$PID" 2>/dev/null; then
            echo "File Browser: ✅ Online"
        else
            echo "File Browser: ❌ Offline"
        fi
    else
        echo "File Browser: ❌ Offline"
    fi


    if [ -f "$SERVER/estado/transmission.pid" ]; then
        PID=$(cat "$SERVER/estado/transmission.pid")

        if kill -0 "$PID" 2>/dev/null; then
            echo "Transmission: ✅ Online"
        else
            echo "Transmission: ❌ Offline"
        fi
    else
        echo "Transmission: ❌ Offline"
    fi


    if [ -f "$SERVER/estado/jellyfin.pid" ]; then
        PID=$(cat "$SERVER/estado/jellyfin.pid")

        if kill -0 "$PID" 2>/dev/null; then
            echo "Jellyfin: ✅ Online"
        else
            echo "Jellyfin: ❌ Offline"
        fi
    else
        echo "Jellyfin: ❌ Offline"
    fi


    if [ -f "$SERVER/estado/web.pid" ]; then
        PID=$(cat "$SERVER/estado/web.pid")

        if kill -0 "$PID" 2>/dev/null; then
            echo "Dashboard Web: ✅ Online"
        else
            echo "Dashboard Web: ❌ Offline"
        fi
    else
        echo "Dashboard Web: ❌ Offline"
    fi
}



start_server()
{
    echo "🚀 Iniciando $NOME_SERVIDOR..."

    echo
    echo "Os serviços estão sendo carregados."

    "$SERVER/administracao/server-start.sh"

    echo
    echo "✅ Processo de inicialização iniciado."

    echo
    echo "Use /status para acompanhar os serviços."
    echo "Use /ajuda para ver os comandos disponíveis."
}


about_server()
{
    echo "🤖 $NOME_SERVIDOR"
    echo
    echo "Servidor doméstico inteligente."
    echo
    echo "📌 Versão: $VERSAO"
    echo "🇧🇷 Edição: $EDICAO"
    echo "📱 Plataforma: $PLATAFORMA"
    echo
    echo "Recursos:"
    echo
    echo "✅ Gerenciamento de serviços"
    echo "✅ Monitoramento automático"
    echo "✅ Dashboard Web"
    echo "✅ Bot Telegram"
    echo
    echo "Use /ajuda para ver os comandos disponíveis."
}

restart_server()
{
    echo "🔄 Reiniciando servidor..."

    "$SERVER/administracao/restart-server.sh"

    echo
    echo "✅ Processo de reinicialização iniciado."

    echo
    echo "Os serviços estão sendo carregados novamente."

    echo
    echo "Use /status para acompanhar."
    echo "Use /ajuda para ver os comandos disponíveis."
}

stop_server()
{
    echo "🛑 Parando servidor..."

    "$SERVER/administracao/server-stop.sh"

    sleep 3

    echo "🔴 Servidor parado."
}
<<<<<<< HEAD









ssh_status(){

    SERVER="$HOME/server"

    source "$SERVER/instalacao/scripts/lib/instalador.sh"


    MSG="🔐 Acesso SSH\n\n"


    if pgrep -f "sshd" > /dev/null; then
        MSG+="Status: Online\n\n"
    else
        MSG+="Status: Offline\n\n"
    fi


    USUARIO=$(whoami)


    PORTA=$(ss -tln 2>/dev/null | grep ssh | awk '{print $4}' | sed 's/.*://' | head -n1)


    if [ -z "$PORTA" ]; then
        PORTA="8022"
    fi


    IP_LOCAL=$(obter_ip_local)


    IP_TS=$(obter_ip_tailscale)


    MSG+="Usuário: $USUARIO\n"
    MSG+="Porta: $PORTA\n\n"


    MSG+="🏠 Rede Local:\n"

    if [ -n "$IP_LOCAL" ]; then

        MSG+="ssh $USUARIO@$IP_LOCAL -p $PORTA\n\n"

    else

        MSG+="Indisponível\n\n"

    fi


    MSG+="🌐 Tailscale:\n"

    if [ -n "$IP_TS" ]; then

        MSG+="ssh $USUARIO@$IP_TS -p $PORTA\n"

    else

        MSG+="Tailscale desligado ou sem conexão\n"

    fi


    echo -e "$MSG"

}
=======
>>>>>>> 8e05702de8ad78080ad86757441a6374ca1753a1
