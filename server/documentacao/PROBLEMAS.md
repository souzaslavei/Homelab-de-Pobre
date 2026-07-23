# Problemas conhecidos

Este documento apresenta limitações, problemas conhecidos e pontos de atenção da versão atual do Homelab de Pobre.

O objetivo desta documentação é registrar situações encontradas durante o desenvolvimento, testes e utilização do servidor, deixando claro quais limitações são do projeto e quais são características dos próprios dispositivos utilizados.

---

# Limitação no cálculo de uso da CPU

Um dos problemas conhecidos do projeto é o cálculo de utilização da CPU.

Durante o desenvolvimento foram realizados diversos testes utilizando diferentes métodos de leitura das informações do processador disponíveis no Android e no Termux.

Apesar das tentativas realizadas, não foi possível obter um cálculo de uso da CPU considerado totalmente confiável e consistente em todos os cenários.

As informações disponíveis pelo sistema Android não seguem necessariamente o mesmo modelo encontrado em servidores Linux tradicionais, o que dificulta obter uma porcentagem precisa de utilização do processador.

Por esse motivo, a informação de CPU apresentada pelo sistema deve ser considerada uma estimativa e não uma medição profissional.

O restante das informações de hardware, como memória, armazenamento, bateria e tempo ligado, funciona normalmente dentro das limitações do ambiente Android.

---

# Limitação de transcodificação no Jellyfin

O Jellyfin funciona corretamente no Homelab de Pobre quando a reprodução utiliza Direct Play.

Nesse cenário, o servidor apenas entrega o arquivo original para o dispositivo responsável pela reprodução, reduzindo drasticamente o processamento necessário.

O problema aparece quando é necessário realizar transcodificação.

Como o projeto utiliza smartphones reaproveitados como servidores, não existe uma GPU dedicada ou uma estrutura de aceleração de vídeo adequada para esse tipo de tarefa.

Quando ocorre uma transcodificação, todo o processamento depende principalmente da CPU do próprio smartphone.

Em dispositivos simples, essa capacidade pode ser limitada e causar:

- aumento do uso do processador;
- consumo elevado de bateria;
- aquecimento do aparelho;
- travamentos ou redução da qualidade da reprodução.

Para obter a melhor experiência, recomenda-se utilizar mídias compatíveis com o dispositivo que realizará a reprodução.

A compatibilidade entre o formato do arquivo, o aplicativo utilizado para assistir e o dispositivo cliente é fundamental para manter o funcionamento em Direct Play.

---

# Limitações de hardware

O Homelab de Pobre foi desenvolvido justamente utilizando dispositivos considerados simples ou reaproveitados.

Por esse motivo, existem limitações naturais relacionadas ao hardware:

- quantidade de memória RAM disponível;
- capacidade do processador;
- velocidade do armazenamento interno;
- capacidade térmica do aparelho;
- ausência de componentes dedicados encontrados em servidores tradicionais.

O projeto não tem como objetivo substituir servidores profissionais, mas demonstrar que equipamentos simples podem executar serviços reais quando existe uma arquitetura organizada e otimizada.

---

# Dependência do ambiente Android

O servidor funciona diretamente sobre o Termux, utilizando o Android como base.

Por depender desse ambiente, algumas limitações existentes no próprio Android também afetam o projeto.

Entre elas:

- gerenciamento agressivo de bateria realizado por alguns fabricantes;
- alterações de permissões após atualizações do sistema;
- limitações impostas pelo Android para processos em segundo plano.

Para maior estabilidade, recomenda-se configurar corretamente as permissões do Termux, Termux:API e Termux:Boot, além de desativar otimizações de bateria que possam interromper os serviços.

---

# Armazenamento limitado

O armazenamento disponível depende diretamente do dispositivo utilizado como servidor.

Apesar de ser possível utilizar smartphones simples, a quantidade de espaço influencia diretamente a capacidade de armazenamento de arquivos, mídias e downloads.

No Homelab de Pobre, a organização das pastas foi criada para facilitar o gerenciamento:

- Home/Midia para bibliotecas do Jellyfin;
- Home/Downloads/Temporarios para downloads em andamento;
- Home/Downloads/Concluidos para arquivos finalizados.

A expansão do armazenamento depende das possibilidades do próprio aparelho utilizado.

---

# Considerações finais

As limitações apresentadas não impedem o funcionamento do Homelab de Pobre.

O projeto foi desenvolvido para demonstrar que um smartphone reaproveitado pode executar funções reais de servidor doméstico utilizando automação, monitoramento e organização adequada.

Conhecer essas limitações é importante para escolher corretamente o uso do servidor, mantendo expectativas compatíveis com o hardware disponível.
