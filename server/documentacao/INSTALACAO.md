# Instalação

Guia completo para instalação do Homelab de Pobre em um dispositivo Android.

---

## Requisitos

Antes de iniciar, certifique-se de possuir:

- Smartphone Android;
- Termux instalado pelo F-Droid;
- Termux:API instalado pelo F-Droid;
- Termux:Boot instalado pelo F-Droid;
- Conexão com a internet;
- Espaço disponível no armazenamento interno.

O projeto foi desenvolvido para funcionar em dispositivos reaproveitados e de baixo custo.

---

# 1. Preparação do Termux

Instale os aplicativos necessários:

- Termux;
- Termux:API;
- Termux:Boot.

Abra o Termux:Boot e o Termux:API pela primeira vez e conceda todas as permissões seguindo as instruções que os próprios APPs dão. Após abrir o Termux pela primeira vez, permita o acesso ao armazenamento compartilhado.

Execute:

    termux-setup-storage

Atualize os pacotes:

    pkg update && pkg upgrade -y

Instale os pacotes necessários:

    pkg install git wget curl python openssh -y

---

# 2. Obtendo o projeto

O Homelab de Pobre disponibiliza a pasta `server` já organizada com todos os arquivos necessários.

Existem duas formas de obter o projeto.

---

## Opção 1: Clonando o repositório

Caso utilize Git:

    git clone https://github.com/souzaslavei/Homelab-de-Pobre

O Git irá criar uma nova pasta utilizando o nome do repositório.

Exemplo:

    Homelab-de-Pobre

Entre na pasta criada:

    cd Homelab-de-Pobre

Verifique se a pasta `server` está presente:

    ls

O resultado deve mostrar a pasta:

    server

Agora copie a pasta do servidor para a raiz do Termux:

    cp -r server ~/server

O caminho final esperado é:

    ~/server

A partir desse ponto, todos os scripts do projeto utilizarão a estrutura correta.

---

## Opção 2: Baixando o ZIP

Caso prefira baixar o projeto em formato ZIP:

1. Baixe o arquivo pelo GitHub;
2. Extraia o conteúdo;
3. Entre na pasta extraída utilizando o terminal.

Exemplo:

    cd NOME_DA_PASTA_EXTRAIDA

Verifique se existe a pasta:

    ls

Confirme que aparece:

    server

Copie a pasta para a raiz do Termux:

    cp -r server ~/server

O caminho final esperado é:

    ~/server

A estrutura interna da pasta `server` não deve ser alterada.

Não renomeie arquivos, não mova pastas internas e não reorganize os diretórios.

Os scripts do Homelab de Pobre dependem dos caminhos originais do projeto.

---

# 3. Executando o instalador

Entre na pasta do servidor:

    cd ~/server

Dê permissão aos scripts:

    find ~/server -type f -name "*.sh" -exec chmod +x {} +

Execute o instalador:

    bash install.sh

O instalador será responsável por:

- preparar o ambiente;
- instalar dependências;
- criar diretórios necessários;
- configurar serviços;
- configurar inicialização automática;
- iniciar o servidor.

Aguarde o processo terminar.

---

# 4. Informações exibidas no final da instalação

Ao finalizar, o instalador exibirá informações importantes para o primeiro acesso.

Entre elas:

- usuário e senha inicial do File Browser;
- informações necessárias para acesso aos serviços;
- status inicial do servidor.

Guarde essas informações.

---

# 5. Configuração inicial dos serviços

Após a instalação, alguns serviços precisam de configuração feita pelo próprio usuário.

---

## File Browser

O File Browser já estará instalado e funcionando.

O primeiro acesso deve ser realizado utilizando o usuário e senha informados pelo instalador.

Após entrar, o usuário poderá alterar essas informações conforme desejar.

---

## Jellyfin

O Jellyfin exige uma configuração inicial pelo navegador.

No primeiro acesso:

- crie o usuário administrador;
- defina uma senha;
- configure as bibliotecas de mídia.

As pastas de mídia já são criadas automaticamente pelo projeto.

Localização:

    Home/Midia

Estrutura recomendada:

    Home/Midia/Filmes

    Home/Midia/Series

    Home/Midia/Animes

No Jellyfin, cadastre essas pastas como bibliotecas.

Sugestão:

- Biblioteca Filmes → Home/Midia/Filmes
- Biblioteca Séries → Home/Midia/Series
- Biblioteca Animes → Home/Midia/Animes

O Jellyfin somente utilizará essas mídias após as bibliotecas serem configuradas pelo usuário.

---

## Transmission

O Transmission já possui os diretórios configurados.

Os downloads seguem esta organização:

Downloads temporários:

    Home/Downloads/Temporarios

Downloads concluídos:

    Home/Downloads/Concluidos

Enquanto um download está em andamento, ele permanece na pasta:

    Temporarios

Após finalizar, o arquivo é movido automaticamente para:

    Concluidos

---

# 6. Configurações opcionais

As configurações abaixo normalmente não precisam ser alteradas.

Elas existem apenas para usuários que desejam personalizar o servidor posteriormente.

---

## Identidade do servidor

Arquivo:

    ~/server/configuracoes/identidade.conf

Pode ser utilizado para alterar informações como nome do servidor.

---

## Telegram Bot

Arquivo:

    ~/server/bot/config.sh

Pode ser utilizado para alterar configurações do bot, como:

- token;
- permissões;
- usuários autorizados.

Essas configurações já são solicitadas durante a instalação inicial.

---

# 7. Primeiro acesso e utilização

Após a instalação:

- o servidor inicia automaticamente com o Android;
- os serviços permanecem em execução;
- o acesso pode ser realizado remotamente.

Serviços disponíveis:

- SSH;
- File Browser;
- Transmission;
- Jellyfin;
- Dashboard Web;
- Telegram Bot.

---

# Instalação concluída

O Homelab de Pobre está instalado.

O dispositivo Android agora funciona como um servidor doméstico com serviços automatizados, monitoramento e acesso remoto.
