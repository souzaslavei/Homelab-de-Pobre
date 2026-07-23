#!/data/data/com.termux/files/usr/bin/bash

LOG="$HOME/server/registros/instalacao.log"

mkdir -p "$HOME/server/registros"

echo "$(date) - ===============================" >> "$LOG"
echo "$(date) - Preparação do Termux iniciada" >> "$LOG"


echo "================================="
echo " PREPARAÇÃO DO TERMUX"
echo " Homelab de Pobre"
echo "================================="
echo


if [ ! -d "/data/data/com.termux/files/home" ]; then
    echo "✗ Este script precisa ser executado no Termux."
    exit 1
fi


echo "=== Atualizando pacotes ==="

if pkg update -y >> "$LOG" 2>&1; then
    echo "✓ Repositórios atualizados"
else
    echo "⚠ Falha ao atualizar repositórios"
fi


echo

echo "=== Instalando dependências ==="

PACOTES="
bash:bash
openssh:sshd
python:python
git:git
curl:curl
wget:wget
tmux:tmux
termux-api:termux-battery-status
"

for ITEM in $PACOTES
do

    PACOTE="${ITEM%%:*}"
    COMANDO="${ITEM##*:}"

    echo "Verificando $PACOTE..."

    if command -v "$COMANDO" >/dev/null 2>&1; then

        echo "✓ $PACOTE já instalado"
        echo "$(date) - $PACOTE já instalado" >> "$LOG"

    else

        echo "Instalando $PACOTE..."

        pkg install "$PACOTE" -y >> "$LOG" 2>&1

        if command -v "$COMANDO" >/dev/null 2>&1; then
            echo "✓ $PACOTE instalado"
            echo "$(date) - $PACOTE instalado" >> "$LOG"
        else
            echo "✗ Erro ao instalar $PACOTE"
            echo "$(date) - ERRO $PACOTE" >> "$LOG"
        fi

    fi

done
echo "=== Verificação final ==="

ERROS=0

PACOTES_VERIFICACAO="
bash:bash
openssh:sshd
python:python
git:git
curl:curl
wget:wget
tmux:tmux
termux-api:termux-battery-status
"

for ITEM in $PACOTES_VERIFICACAO
do

    PACOTE="${ITEM%%:*}"
    COMANDO="${ITEM##*:}"

    if command -v "$COMANDO" >/dev/null 2>&1; then
        echo "✓ $PACOTE"
    else
        echo "✗ $PACOTE ausente"
        ERROS=$((ERROS+1))
    fi

done


echo

if [ "$ERROS" -eq 0 ]; then

    echo "✓ Ambiente Termux preparado"
    echo "$(date) - Preparação concluída com sucesso" >> "$LOG"

else

    echo "⚠ Existem $ERROS problema(s)"
    echo "$(date) - Preparação concluída com erros" >> "$LOG"

fi


echo "$(date) - ===============================" >> "$LOG"
