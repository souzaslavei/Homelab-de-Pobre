#!/data/data/com.termux/files/usr/bin/bash

echo "================================="
echo "  VERIFICADOR DE AMBIENTE"
echo "  Homelab de Pobre"
echo "================================="
echo

ERROS=0

echo "=== SISTEMA ==="

if [ -d "/data/data/com.termux/files/home" ]; then
    echo "✓ Termux detectado"
else
    echo "✗ Termux não encontrado"
    ERROS=$((ERROS+1))
fi


echo

echo "=== ARQUITETURA ==="

ARQ=$(uname -m)

echo "Arquitetura: $ARQ"

case "$ARQ" in
    aarch64|arm64)
        echo "✓ Arquitetura ARM64 compatível"
        ;;
    armv7l|i686|x86_64)
        echo "⚠ Arquitetura detectada, verificar compatibilidade"
        ;;
    *)
        echo "✗ Arquitetura desconhecida"
        ERROS=$((ERROS+1))
        ;;
esac


echo

echo "=== ARMAZENAMENTO ==="

if [ -d "/storage/emulated/0" ]; then
    echo "✓ Armazenamento Android acessível"
else
    echo "⚠ Permissão de armazenamento não encontrada"
    echo
    echo "Solicitando permissão do Android..."
    echo
    termux-setup-storage

    echo
    echo "Aguardando configuração..."
    sleep 3

    if [ -d "/storage/emulated/0" ]; then
        echo "✓ Armazenamento Android configurado"
    else
        echo "✗ Armazenamento ainda indisponível"
        echo "Execute manualmente: termux-setup-storage"
        ERROS=$((ERROS+1))
    fi
fi


echo

echo "=== TERMUX:API ==="

if command -v termux-battery-status >/dev/null 2>&1; then
    echo "✓ Termux:API encontrado"
else
    echo "✗ Termux:API não encontrado"
    echo "Instale o pacote termux-api no Termux"
    ERROS=$((ERROS+1))
fi


echo

echo "=== TERMUX:BOOT ==="

if [ -d "$HOME/.termux/boot" ]; then
    echo "✓ Pasta do Termux:Boot encontrada"
else
    echo "⚠ Pasta do Termux:Boot não encontrada"
    echo "Será criada durante a instalação"
fi


echo

echo "=== DEPENDÊNCIAS BÁSICAS ==="

for CMD in bash curl wget git python ssh tmux; do

    if command -v "$CMD" >/dev/null 2>&1; then
        echo "✓ $CMD"
    else
        echo "✗ $CMD ausente"
        ERROS=$((ERROS+1))
    fi

done


echo

echo "================================="

if [ "$ERROS" -eq 0 ]; then
    echo "✓ Ambiente pronto para instalação"
else
    echo "⚠ Foram encontradas $ERROS dependências ausentes"
fi

echo "================================="
