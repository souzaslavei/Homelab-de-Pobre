# Homelab de Pobre

Transformando um smartphone simples em um servidor doméstico completo utilizando software livre.

---

## Sobre o projeto

O **Homelab de Pobre** é um projeto que demonstra como um smartphone Android comum pode ser reaproveitado como um servidor doméstico funcional, utilizando ferramentas gratuitas e uma arquitetura organizada.

A proposta do projeto é transformar um dispositivo de baixo custo em uma pequena infraestrutura de servidor capaz de oferecer serviços reais, como armazenamento de arquivos, servidor de mídia, downloads automatizados, monitoramento e administração remota.

Mais do que apenas instalar aplicativos, o projeto busca criar uma estrutura semelhante à utilizada em servidores tradicionais, utilizando:

- Termux;
- ferramentas compatíveis com Linux;
- serviços independentes;
- scripts de automação;
- monitoramento automático;
- gerenciamento remoto;
- documentação completa.

---

## Filosofia do projeto

O Homelab de Pobre nasceu com uma ideia simples:

> Demonstrar que é possível aprender servidores, redes e administração Linux utilizando equipamentos acessíveis e reaproveitados.

O projeto segue alguns princípios:

- reaproveitamento de hardware;
- baixo custo;
- uso de software livre;
- automação sempre que possível;
- organização dos arquivos;
- facilidade de manutenção;
- documentação para reprodução.

A ideia não é substituir servidores profissionais, mas mostrar que equipamentos considerados limitados ainda podem ter uma nova utilidade.

---

## Visão geral da arquitetura

O Homelab de Pobre utiliza um smartphone Android como servidor doméstico, executando todos os serviços diretamente no Termux, sem necessidade de instalar uma distribuição Linux adicional.

A arquitetura foi desenvolvida para funcionar de forma independente, permitindo que o servidor seja instalado, configurado e administrado remotamente.

A estrutura principal é composta por:

- **Termux:** ambiente principal responsável por executar diretamente os serviços, scripts e ferramentas do servidor no Android;
- **SSH:** permite administração completa do servidor através da rede;
- **Scripts próprios:** automatizam inicialização, desligamento, reinício e manutenção;
- **Watchdog:** monitora os serviços e realiza tentativas de recuperação automática;
- **Bot Telegram:** permite acompanhar e administrar o servidor remotamente;
- **Dashboard Web:** apresenta informações do servidor através de uma interface gráfica.

---

Diferentemente de muitos projetos semelhantes, o Homelab de Pobre não depende de máquinas virtuais, containers ou distribuições Linux completas executadas sobre o Android. Toda a infraestrutura foi desenvolvida para funcionar diretamente no Termux, reduzindo o consumo de recursos, simplificando a instalação e facilitando a manutenção.

---

## Administração totalmente remota

Uma das características principais do projeto é a possibilidade de realizar todo o processo de instalação e configuração através de SSH.

O servidor foi desenvolvido considerando cenários onde o dispositivo pode estar:

- sem tela funcional;
- sem acesso físico constante;
- instalado em um local remoto;
- funcionando continuamente como uma máquina de servidor.

Por esse motivo, o SSH permanece sempre ativo no sistema, permitindo:

- instalação de componentes;
- atualização de arquivos;
- manutenção dos serviços;
- consulta de informações;
- correção de problemas.

Esse modelo foi validado utilizando o próprio dispositivo principal do projeto, um smartphone Realme com tela quebrada, demonstrando que um equipamento aparentemente inutilizável ainda poderia funcionar como uma máquina de servidor.

---

## Serviços disponíveis

O servidor possui uma arquitetura baseada em serviços independentes. Cada aplicação possui seu próprio script de gerenciamento, arquivos de configuração, registros e controle de processo.

Serviços principais:

### SSH
Responsável pelo acesso remoto ao servidor através do terminal.

Permite administrar completamente o dispositivo sem necessidade de interação física.

---

### File Browser

Servidor de arquivos acessível pelo navegador.

Possibilita:

- visualizar arquivos;
- enviar e baixar documentos;
- organizar armazenamento;
- acessar dados remotamente.

---

### Transmission

Gerenciador de downloads automatizados.

Permite controlar downloads através da interface web e manter arquivos organizados no armazenamento do servidor.

---

### Jellyfin

Servidor de mídia pessoal.

Permite transformar o smartphone em uma central multimídia para:

- filmes;
- séries;
- músicas;
- vídeos pessoais.

---

### Dashboard Web

Interface própria desenvolvida para visualizar o estado do servidor.

Exibe informações como:

- serviços ativos;
- informações de hardware;
- tempo ligado;
- endereços de acesso;
- status geral do sistema.

---

### Bot Telegram

Sistema de gerenciamento remoto através do Telegram.

Permite consultar informações e executar ações sem acessar diretamente o terminal.

Entre os recursos disponíveis:

- verificar status do servidor;
- consultar hardware;
- visualizar serviços ativos;
- reiniciar componentes;
- acompanhar alertas.

---

## Monitoramento e recuperação automática

Para aumentar a confiabilidade do sistema, o projeto possui um mecanismo de monitoramento contínuo.

O **Watchdog** verifica periodicamente:

- disponibilidade dos serviços;
- funcionamento dos processos;
- espaço disponível em armazenamento;
- condições básicas do sistema.

Quando um serviço apresenta falha, o sistema tenta realizar uma recuperação automática através dos próprios scripts de inicialização.

Essa abordagem aproxima o funcionamento do projeto ao conceito utilizado em servidores tradicionais, onde sistemas de monitoramento são utilizados para reduzir tempo de indisponibilidade.

---

## Documentação

O Homelab de Pobre possui uma documentação completa para auxiliar na instalação, utilização, manutenção e entendimento do projeto.

Antes de utilizar ou modificar o servidor, recomenda-se consultar os arquivos disponíveis na pasta:

    documentacao/

Neles estão disponíveis informações detalhadas sobre:

- instalação do projeto;
- arquitetura do sistema;
- organização dos arquivos;
- funcionamento dos serviços;
- manutenção;
- solução de problemas;
- desenvolvimento e contribuições.

Consulte cada documento conforme sua necessidade para obter uma visão completa do funcionamento do Homelab de Pobre.

---

## Licença

Este projeto utiliza a licença MIT.