#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"

source "$SERVER/bot/telegram.sh"
source "$SERVER/bot/functions.sh"

process_command()
{
    CHAT_ID="$1"
    COMMAND="$2"

    case "$COMMAND" in

/ssh)
send_message_chat "$CHAT_ID" "$(ssh_status)"
;;


        /iniciar|/start)
            send_message_chat "$CHAT_ID" "$(start_server)"
            ;;

        /status)
            send_message_chat "$CHAT_ID" "$(server_status)"
            ;;



        /sobre)
            send_message_chat "$CHAT_ID" "$(about_server)"
            ;;

        /hardware)
            send_message_chat "$CHAT_ID" "$(hardware_status)"
            ;;

        /logs)
            send_message_chat "$CHAT_ID" "$(logs_status)"
            ;;

        /servicos|/services)
            send_message_chat "$CHAT_ID" "$(services_status)"
            ;;

        /enderecos|/urls)
            send_message_chat "$CHAT_ID" "$(enderecos_status)"
            ;;

        /reiniciar|/restart)
            send_message_chat "$CHAT_ID" "$(restart_server)"
            ;;

        /parar)
            send_message_chat "$CHAT_ID" "$(stop_server)"
            ;;

        /ajuda|/help)
            send_message_chat "$CHAT_ID" "📌 Comandos disponíveis:

/iniciar - Iniciar servidor
/status - Status do servidor
/hardware - Informações do hardware
/logs - Últimos logs
/servicos - Status dos serviços
/enderecos - Endereços dos serviços
/reiniciar - Reiniciar servidor
/parar - Parar servidor
/ssh - Mostrar comando de conexão SSH
/sobre - Informações do servidor
/ajuda - Ajuda"
            ;;

        *)
            send_message_chat "$CHAT_ID" "❌ Comando desconhecido: $COMMAND

Use /ajuda para ver os comandos disponíveis."
            ;;

    esac
}
