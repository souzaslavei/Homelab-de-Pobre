# Comandos

Manual de operação e administração do Homelab de Pobre.

Este documento apresenta os principais comandos utilizados para controlar o servidor através do terminal e do Bot Telegram.

Existem dois tipos principais de comandos:

- comandos executados diretamente pelo terminal do Termux;
- comandos enviados através do Bot Telegram.

Antes de realizar alterações no sistema, recomenda-se verificar o estado atual dos serviços e consultar os registros quando necessário.

---

# 1. Comandos pelo terminal

## Acessando a pasta do servidor

Para acessar o diretório principal do projeto:

    cd ~/server

---

# 2. Controle do servidor

## Iniciar o servidor

Comando:

    bash ~/server/startup.sh

Esse comando inicia o processo principal do Homelab de Pobre.

Durante a inicialização são preparados os diretórios necessários e iniciados os componentes configurados do servidor.

---

## Verificar o status dos serviços

Comando:

    bash ~/server/administracao/server-status.sh

Esse comando apresenta informações sobre o funcionamento dos principais componentes:

- SSH;
- File Browser;
- Transmission;
- Jellyfin;
- Dashboard Web;
- Telegram Bot;
- Watchdog.

É recomendado utilizar esse comando antes e depois de realizar alterações.

---

## Reiniciar o servidor

Comando:

    bash ~/server/administracao/server-restart.sh

Utilize quando:

- realizar alterações de configuração;
- atualizar componentes;
- algum serviço apresentar comportamento incorreto.

---

## Parar o servidor

Comando:

    bash ~/server/administracao/server-stop.sh

Esse comando encerra os serviços de forma controlada.

Recomendado antes de manutenções ou alterações importantes.

---

# 3. Diagnóstico e registros

## Listar registros do sistema

Comando:

    ls ~/server/registros

A pasta de registros contém informações importantes para diagnóstico.

---

## Consultar o log do Watchdog

Comando:

    cat ~/server/registros/watchdog.log

O Watchdog registra verificações dos serviços e tentativas de recuperação automática.

---

## Acompanhar um log em tempo real

Comando:

    tail -f ~/server/registros/watchdog.log

Útil para acompanhar o funcionamento do monitoramento enquanto o servidor está ativo.

---

# 4. Permissões dos scripts

Caso algum script deixe de funcionar por falta de permissão:

Comando:

    find ~/server -type f -name "*.sh" -exec chmod +x {} +

Esse comando garante novamente permissão de execução para os scripts do projeto.

---

# 5. Ver processos ativos

Para visualizar processos em execução:

Comando:

    ps aux

Para procurar processos relacionados ao servidor:

Comando:

    ps aux | grep server

---

# 6. Atualização do projeto

## Atualização usando Git

Caso o projeto tenha sido instalado através de um repositório Git:

Comandos:

    cd ~/server

    git pull

Antes de atualizar, recomenda-se realizar um backup caso existam configurações personalizadas.

---

## Atualização utilizando ZIP

Caso a instalação tenha sido feita através de arquivo ZIP:

- faça uma cópia da pasta atual;
- substitua os arquivos do projeto;
- preserve configurações personalizadas quando necessário.

---

# 7. Comandos do Bot Telegram

O Bot Telegram permite acompanhar e administrar o Homelab de Pobre remotamente, sem necessidade de acesso direto ao terminal.

Os comandos disponíveis são:

---

## /iniciar

Inicia o servidor.

Utilizado quando o sistema precisa ser iniciado manualmente.

---

## /status

Exibe o estado geral do servidor.

Pode apresentar informações como:

- tempo ligado;
- estado atual do sistema;
- funcionamento geral.

---

## /hardware

Mostra informações do hardware do dispositivo.

Pode apresentar:

- memória RAM;
- armazenamento;
- bateria;
- processador;
- outras informações disponíveis do sistema.

---

## /logs

Exibe os registros recentes do servidor.

Útil para verificar eventos recentes e auxiliar na identificação de problemas.

---

## /servicos

Mostra o estado dos serviços monitorados.

Permite verificar rapidamente quais componentes estão ativos.

Serviços acompanhados:

- SSH;
- File Browser;
- Transmission;
- Jellyfin;
- Dashboard Web;
- Watchdog;
- Bot Telegram.

---

## /enderecos

Exibe os endereços de acesso dos serviços disponíveis no servidor.

O comando verifica dinamicamente os endereços atuais configurados e apresenta as opções de acesso conforme a rede disponível.

Pode apresentar:

- acesso pela Rede Local;
- acesso pelo Tailscale;
- Dashboard Web;
- File Browser;
- Jellyfin;
- outros serviços configurados.

Os endereços exibidos podem mudar conforme:

- alteração do IP da rede local;
- mudança da configuração do Tailscale;
- alterações nos serviços ativos.

O objetivo do comando é fornecer os links atualizados para acesso remoto ao servidor sem depender de informações salvas anteriormente.

---

## /reiniciar

Reinicia o servidor.

Utilize quando:

- realizar alterações de configuração;
- algum serviço apresentar falha;
- for necessário reiniciar os componentes do sistema.

Após executar, aguarde alguns momentos para que todos os serviços sejam iniciados novamente.

---

## /parar

Para o servidor de forma controlada.

Recomendado antes de:

- manutenções;
- alterações importantes;
- desligamento prolongado do dispositivo.

---

## /sobre

Exibe informações gerais do Homelab de Pobre.

Pode apresentar:

- versão do servidor;
- informações do projeto;
- identificação da instalação.

---

## /ajuda

Mostra a lista de comandos disponíveis do Bot Telegram.

Utilize quando precisar consultar as funções disponíveis.

---

## /ssh

Exibe o comando completo necessário para conexão SSH com o servidor.

O comando é gerado dinamicamente no momento da solicitação, verificando automaticamente:

- usuário atual do sistema;
- porta SSH atualmente utilizada;
- endereço IP da rede local;
- endereço IPv4 do Tailscale.

Exemplo de retorno:

Acesso SSH

Status: Online

Rede Local:
ssh usuario@IP_LOCAL -p PORTA

Tailscale:
ssh usuario@IP_TAILSCALE -p PORTA

O comando exibido deve ser utilizado diretamente no terminal para realizar a conexão SSH.

As informações apresentadas podem mudar conforme o estado atual da rede, IPs disponíveis ou configurações do servidor.

---

# 8. Solução rápida de problemas

Caso o servidor apresente problemas:

Primeiro verifique o estado dos serviços:

    bash ~/server/administracao/server-status.sh

Depois consulte os registros:

    tail -50 ~/server/registros/watchdog.log

Caso necessário, reinicie o servidor:

    bash ~/server/administracao/server-restart.sh

---

# 9. Boas práticas

Recomendações:

- não apagar arquivos internos da pasta server;
- não mover diretórios do projeto;
- realizar backups antes de alterações;
- utilizar os scripts administrativos ao invés de iniciar serviços manualmente;
- consultar registros antes de modificar configurações.

O Homelab de Pobre foi desenvolvido para funcionar de forma automatizada, portanto a administração deve priorizar os comandos oficiais do projeto.

---

# Conclusão

Com estes comandos é possível realizar a administração diária do Homelab de Pobre, acompanhar o funcionamento dos serviços e realizar manutenções básicas do servidor.
