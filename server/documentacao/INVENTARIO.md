# Inventário

Este documento registra os equipamentos utilizados durante o desenvolvimento, validação e funcionamento do Homelab de Pobre.

O objetivo é documentar quais dispositivos participaram da criação do projeto, quais foram utilizados em produção e quais serviram apenas para testes.

Uma das principais propostas do Homelab de Pobre é demonstrar que uma infraestrutura de servidor doméstico pode ser criada utilizando equipamentos simples, reaproveitados e com baixo custo.

---

# Equipamentos utilizados

## Realme Note 50 — Servidor principal

O Realme Note 50 é o dispositivo utilizado atualmente como servidor principal do Homelab de Pobre.

A escolha deste aparelho representa exatamente a proposta do projeto: reaproveitar equipamentos que seriam descartados e transformar esses dispositivos em uma pequena infraestrutura funcional.

O aparelho utilizado no projeto foi reaproveitado após se tornar inutilizável para uso convencional.

A tela está completamente comprometida, impossibilitando uma utilização normal como smartphone. Porém, como o funcionamento interno do aparelho continua preservado, ele encontrou uma nova finalidade como servidor doméstico.

Essa característica também foi importante para validar uma das ideias centrais do projeto: um dispositivo que perdeu sua utilidade original ainda pode possuir valor para outras funções.

Mesmo sem depender da tela, o aparelho consegue executar toda a infraestrutura através de acesso remoto utilizando SSH, permitindo administração completa sem necessidade de interação física.

---

## Especificações técnicas do Realme Note 50

- Fabricante: Realme;
- Modelo: Note 50;
- Sistema operacional: Android;
- Interface: Realme UI;
- Processador: Unisoc Tiger T612;
- CPU: Octa-core;
- Frequência máxima aproximada: 1,8 GHz;
- GPU: ARM Mali-G57;
- Memória RAM: 4 GB;
- Armazenamento interno: 128 GB;
- Expansão de armazenamento: cartão microSD;
- Tela: IPS LCD de 6,74 polegadas;
- Resolução: 1600 x 720 pixels;
- Rede móvel: 4G LTE;
- Wi-Fi: Wi-Fi 5;
- Bluetooth: 5.0;
- Bateria: 5000 mAh;
- Conector: USB-C.

---

## Uso do Realme Note 50 no projeto

Atualmente, o Realme Note 50 executa toda a infraestrutura principal do Homelab de Pobre.

Nele estão funcionando:

- Termux como ambiente principal;
- SSH para administração remota;
- File Browser para gerenciamento de arquivos;
- Transmission para downloads automatizados;
- Jellyfin como servidor de mídia;
- Dashboard Web para visualização do sistema;
- Bot Telegram para gerenciamento remoto;
- Watchdog para monitoramento e recuperação automática;
- scripts administrativos para controle do servidor.

O armazenamento interno de 128 GB foi um dos fatores decisivos para manter este aparelho como servidor principal.

O espaço disponível permite armazenar:

- arquivos do sistema;
- serviços;
- registros;
- arquivos temporários;
- biblioteca de mídia.

Apesar de ser um aparelho de entrada, ele demonstrou capacidade suficiente para executar uma infraestrutura completa de servidor doméstico.

---

# Samsung Galaxy A54 5G — Validação do instalador

O Galaxy A54 5G foi utilizado durante o desenvolvimento para validar o processo de instalação automática do Homelab de Pobre.

Ele não é utilizado como servidor principal.

Seu objetivo foi confirmar que o projeto poderia ser instalado em outro aparelho Android sem depender da configuração específica do Realme Note 50.

Durante os testes, foi validado:

- funcionamento do instalador;
- criação automática dos diretórios;
- preparação do ambiente;
- configuração inicial dos serviços;
- inicialização automática.

Esse teste foi importante para garantir que o projeto pudesse ser reproduzido por outros usuários.

---

## Especificações técnicas do Galaxy A54 5G

- Fabricante: Samsung;
- Modelo: Galaxy A54 5G;
- Processador: Samsung Exynos 1380;
- CPU: Octa-core;
- GPU: Mali-G68;
- Memória RAM: 8 GB;
- Armazenamento interno: 128 GB;
- Tela: Super AMOLED de 6,4 polegadas;
- Resolução: Full HD+;
- Taxa de atualização: 120 Hz;
- Rede móvel: 5G;
- Wi-Fi;
- Bluetooth;
- Bateria: 5000 mAh;
- Conector: USB-C.

---

# Tablet Multilaser M8 — Teste de compatibilidade

O Tablet Multilaser M8 foi utilizado como teste complementar para verificar o funcionamento do Homelab de Pobre em um equipamento ainda mais simples.

O objetivo não era utilizá-lo como servidor permanente, mas observar como a arquitetura se comportava em um dispositivo com recursos mais limitados.

O teste demonstrou que o projeto consegue funcionar mesmo em hardware básico.

---

## Especificações técnicas do Multilaser M8

- Fabricante: Multilaser;
- Modelo: M8;
- Categoria: Tablet Android;
- Tela: 8 polegadas;
- Memória RAM: 2 GB;
- Armazenamento interno: 32 GB;
- Sistema operacional: Android;
- Conectividade: Wi-Fi.

---

## Motivo de não utilizar o tablet como servidor principal

Apesar de conseguir executar a estrutura do projeto, o principal problema encontrado foi o armazenamento reduzido.

Com apenas 32 GB disponíveis, existe pouco espaço para manter:

- sistema;
- serviços;
- registros;
- arquivos temporários;
- biblioteca de mídia.

Como o Homelab de Pobre possui serviços como Jellyfin e trabalha com arquivos armazenados localmente, o espaço disponível é um fator importante.

Por esse motivo, o tablet foi utilizado apenas para validação, enquanto o Realme Note 50 permaneceu como servidor principal devido aos seus 128 GB de armazenamento.

---

# Comparação dos equipamentos

O desenvolvimento do Homelab de Pobre passou por três categorias diferentes de dispositivos.

O Realme Note 50 representa o ambiente real de produção do projeto. Mesmo sendo um aparelho simples e com a tela inutilizável, ele consegue executar todos os serviços necessários através de acesso remoto.

O Galaxy A54 5G representa a validação de reprodução do projeto. Por possuir hardware superior, ele serviu para confirmar que o instalador automático funciona em outro ambiente Android.

O Multilaser M8 representa o teste de limite. Mesmo com apenas 2 GB de RAM e 32 GB de armazenamento, ele demonstrou que a arquitetura é capaz de funcionar em dispositivos extremamente básicos.

---

# Conclusão

O Homelab de Pobre foi desenvolvido utilizando equipamentos que demonstram a proposta principal do projeto: aproveitar ao máximo recursos que já existem.

O servidor principal não utiliza um computador dedicado ou hardware especializado.

Ele funciona em um smartphone reaproveitado, com tela comprometida, processador de entrada e apenas 4 GB de RAM.

Mesmo assim, através de:

- organização dos serviços;
- automação;
- scripts próprios;
- monitoramento;
- administração remota;

foi possível transformar um aparelho que seria descartado em um servidor doméstico funcional.

Os testes realizados em diferentes dispositivos demonstraram que o projeto não depende de um único modelo de aparelho e pode ser reproduzido em diferentes cenários.

O objetivo do Homelab de Pobre não é substituir servidores profissionais, mas mostrar que aprendizado em Linux, redes e administração de sistemas pode começar utilizando equipamentos acessíveis e reaproveitados.

