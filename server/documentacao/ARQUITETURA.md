# Arquitetura do Homelab de Pobre

## Visão geral

O Homelab de Pobre transforma um smartphone Android reaproveitado em um servidor doméstico funcional utilizando software livre e ferramentas compatíveis com Linux.

A arquitetura foi desenvolvida para funcionar diretamente sobre o Termux, aproveitando os recursos do próprio Android sem depender de máquinas virtuais, containers ou distribuições Linux completas.

A estrutura geral do sistema segue este fluxo:

Android

↓

Termux

↓

Scripts de gerenciamento

↓

Serviços independentes

↓

Monitoramento e administração remota

---

## Camada base do sistema

## Android

O Android representa a camada física do servidor.

Ele fornece:

- processamento;
- memória;
- armazenamento;
- conexão de rede;
- gerenciamento de energia;
- acesso aos recursos do dispositivo.

O projeto foi desenvolvido pensando principalmente em dispositivos reaproveitados e de baixo custo.

---

## Termux

O Termux funciona como a base operacional do servidor.

Ele é responsável por:

- executar os scripts do projeto;
- iniciar os serviços;
- disponibilizar ferramentas Linux;
- acessar recursos do Android;
- manter o ambiente do servidor funcionando.

O projeto utiliza o Termux como uma camada Linux sobre o Android, evitando a necessidade de instalar um sistema operacional adicional.

---

# Estrutura principal do servidor

A organização dos arquivos foi planejada para facilitar manutenção, expansão e entendimento do projeto.

Estrutura principal:

server/

- administracao/
- bot/
- configuracoes/
- dados/
- documentacao/
- estado/
- instalacao/
- releases/
- registros/
- servicos/
- web/
- backup/
- startup.sh
- watchdog.sh
- install.sh

---

## administracao/

Contém scripts responsáveis pelo gerenciamento do servidor.

Exemplos de funções:

- iniciar serviços;
- parar serviços;
- reiniciar componentes;
- verificar status;
- executar tarefas administrativas.

---

## servicos/

Armazena os componentes individuais executados pelo servidor.

Cada serviço possui seus próprios arquivos de controle e configuração.

Exemplos:

- SSH;
- File Browser;
- Transmission;
- Jellyfin;
- Dashboard Web.

A separação dos serviços permite manutenção independente e facilita futuras expansões.

---

## configuracoes/

Armazena arquivos utilizados para personalização e funcionamento do sistema.

Exemplos:

- identidade do servidor;
- configurações do bot;
- parâmetros dos serviços.

---

## dados/

Diretório destinado aos dados utilizados pelos serviços.

Exemplos:

- arquivos de mídia;
- arquivos baixados;
- informações persistentes.

---

## registros/

Armazena os registros de funcionamento do sistema.

Os logs permitem acompanhar:

- inicialização;
- funcionamento dos serviços;
- falhas;
- alertas;
- ações realizadas pelo sistema.

---

# Processo de inicialização

O processo de inicialização automática funciona da seguinte forma:

Android inicia

↓

Termux:Boot é executado

↓

startup.sh é iniciado

↓

Serviços são verificados

↓

Componentes são iniciados

↓

Watchdog inicia o monitoramento

---

## startup.sh

O arquivo startup.sh é responsável pela preparação inicial do servidor.

Durante sua execução ele:

- verifica o ambiente;
- inicia serviços necessários;
- prepara componentes;
- registra informações nos logs.

Ele representa o ponto principal de entrada do servidor.

---

# Gerenciamento dos serviços

O Homelab de Pobre utiliza uma arquitetura baseada em serviços independentes.

Cada serviço possui:

- script próprio;
- configuração própria;
- registros próprios;
- controle individual.

Essa organização evita que uma falha em um componente comprometa todo o sistema.

---

# Administração do servidor

A administração é realizada através dos scripts presentes na pasta:

administracao/

Eles permitem tarefas como:

- iniciar o servidor;
- parar o servidor;
- reiniciar componentes;
- verificar funcionamento;
- realizar manutenção.

---

# Monitoramento automático

O projeto possui um sistema chamado Watchdog.

O Watchdog acompanha continuamente o estado do servidor.

Ele verifica:

- funcionamento dos processos;
- disponibilidade dos serviços;
- espaço disponível;
- condições básicas do dispositivo.

Quando identifica uma falha, pode tentar realizar uma recuperação automática utilizando os próprios scripts do projeto.

Os registros do monitoramento ficam armazenados na pasta:

registros/

---

# Comunicação e acesso remoto

O Homelab de Pobre foi desenvolvido para permitir administração remota.

## SSH

Permite controlar o servidor através do terminal.

Com SSH é possível:

- executar comandos;
- atualizar arquivos;
- realizar manutenção;
- administrar serviços.

---

## Dashboard Web

O Dashboard Web fornece uma interface gráfica para acompanhar informações do servidor.

Ele apresenta:

- status dos serviços;
- informações de hardware;
- tempo de funcionamento;
- informações de acesso.

---

## Telegram Bot

O Bot Telegram permite acompanhar e administrar o servidor remotamente.

Entre suas funções estão:

- consulta de status;
- informações de hardware;
- verificação de serviços;
- comandos administrativos;
- envio de alertas.

---

## Sistema de endereços dos serviços

O servidor possui um sistema centralizado para geração dos endereços de acesso dos serviços.

Através do script `web/api/enderecos.sh`, o sistema identifica dinamicamente os endereços disponíveis e organiza os acessos em duas categorias:

- Rede local: acesso direto através do IP da rede doméstica.
- Tailscale: acesso remoto através da rede privada criada pelo Tailscale.

Os endereços são utilizados pelo Dashboard Web e pelo Telegram Bot, evitando configurações fixas que podem ficar desatualizadas após mudanças de rede.

O comando `/enderecos` no Telegram consulta essas informações em tempo real e apresenta os links atuais dos serviços disponíveis.

Serviços monitorados pelo sistema de endereços:

- File Browser
- Transmission
- Jellyfin
- Dashboard Web

O Dashboard possui controle visual para alternar entre os acessos da rede local e Tailscale quando necessário.

---

## Tailscale

O Tailscale permite acesso remoto externo através de uma rede privada segura.

Ele possibilita acessar o servidor mesmo fora da rede local sem necessidade de abertura manual de portas no roteador.

---

# Organização dos dados

O servidor utiliza uma estrutura organizada dentro do armazenamento compartilhado do Android.

Exemplo:

Home/

- Midia/
  - Filmes/
  - Series/
  - Animes/

- Downloads/
  - Temporarios/
  - Concluidos/

---

## Jellyfin

O Jellyfin utiliza as pastas dentro de:

Home/Midia/

As bibliotecas são configuradas pelo usuário no primeiro acesso.

Sugestões:

- Filmes;
- Series;
- Animes.

---

## Transmission

O Transmission utiliza:

Home/Downloads/

Durante o download:

Downloads/Temporarios/

Após conclusão:

Downloads/Concluidos/

Essa separação mantém os arquivos organizados automaticamente.

---

# Filosofia da arquitetura

A arquitetura do Homelab de Pobre segue alguns princípios:

- baixo consumo de recursos;
- reaproveitamento de hardware;
- simplicidade;
- modularidade;
- automação;
- facilidade de manutenção;
- documentação completa.

O objetivo não é substituir servidores profissionais, mas demonstrar que equipamentos simples podem executar uma infraestrutura real de aprendizado e uso doméstico.

---

# Fluxo completo do sistema

O funcionamento geral pode ser resumido:

Usuário

↓

SSH / Dashboard / Telegram

↓

Scripts de administração

↓

Serviços

↓

Dados

↓

Monitoramento e recuperação automática