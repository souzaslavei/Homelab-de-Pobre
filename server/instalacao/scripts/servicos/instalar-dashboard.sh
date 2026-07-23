#!/data/data/com.termux/files/usr/bin/bash

# =====================================================
# Homelab de Pobre
# Instalador do Dashboard Web
# =====================================================

LOG="$HOME/server/registros/instalacao.log"

echo "================================="
echo " INSTALAÇÃO DO DASHBOARD WEB"
echo "================================="
echo

echo "$(date) - Instalação do Dashboard iniciada" >> "$LOG"


echo "Verificando Python..."

if command -v python >/dev/null 2>&1; then
    echo "✓ Python disponível"
else
    echo "✗ Python não encontrado"
    exit 1
fi

echo
echo "Instalando dependências do Dashboard..."

if [ -f "$HOME/server/web/requirements.txt" ]; then
    python -m pip install -r "$HOME/server/web/requirements.txt"
    echo "✓ Dependências instaladas"
else
    echo "⚠ requirements.txt não encontrado"
fi


echo
echo "Verificando arquivos do Dashboard..."

if [ -f "$HOME/server/web/app.py" ]; then
    echo "✓ Dashboard encontrado"
else
    echo "✗ app.py não encontrado"
    exit 1
fi


echo
echo "Preparando diretórios..."

mkdir -p "$HOME/server/registros"
mkdir -p "$HOME/server/estado"


echo "✓ Diretórios preparados"


echo
echo "Verificando configuração..."

if [ -f "$HOME/server/web/config.sh" ]; then
    echo "✓ Configuração encontrada"
else
    echo "⚠ config.sh não encontrado"
fi


echo
echo "✓ Instalação concluída."

echo "$(date) - Instalação do Dashboard finalizada" >> "$LOG"

