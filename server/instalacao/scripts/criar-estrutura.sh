#!/data/data/com.termux/files/usr/bin/bash

SERVER="$HOME/server"
LOG="$SERVER/registros/instalacao.log"

mkdir -p "$SERVER/registros"

echo "$(date) - ===============================" >> "$LOG"
echo "$(date) - Criação da estrutura iniciada" >> "$LOG"

echo "================================="
echo " CRIAÇÃO DA ESTRUTURA"
echo " Homelab de Pobre"
echo "================================="
echo


PASTAS="
administracao
bot
dados
documentacao
estado
registros
servicos
web
instalacao
backup
"


for PASTA in $PASTAS
do

    CAMINHO="$SERVER/$PASTA"

    if [ -d "$CAMINHO" ]; then

        echo "✓ $PASTA já existe"
        echo "$(date) - $PASTA já existente" >> "$LOG"

    else

        mkdir -p "$CAMINHO"

        if [ -d "$CAMINHO" ]; then

            echo "✓ $PASTA criada"
            echo "$(date) - $PASTA criada" >> "$LOG"

        else

            echo "✗ Erro ao criar $PASTA"
            echo "$(date) - ERRO ao criar $PASTA" >> "$LOG"

        fi

    fi

done


echo

echo "=== Estrutura criada ==="

find "$SERVER" -maxdepth 1 -type d | sort


echo "$(date) - Criação da estrutura concluída" >> "$LOG"
echo "$(date) - ===============================" >> "$LOG"
