#!/bin/sh

set -e

KeyFile="$HOME/.ssh/known_hosts"

if [ -n "$1" ] ; then
    SSH_HOST_KEY="$1"
elif [ -n "$SSH_HOST_KEY" ] ; then
    echo "Variável de ambiente SSH_HOST_KEY detectada."
else
    echo "Fatal: nenhuma chave SSH de host definida." >&2
    exit 1
fi

mkdir -p -m 700 ~/.ssh

echo "Instalando chave SSH de host."

echo "$SSH_HOST_KEY" >> "$KeyFile"

chmod 600 "$KeyFile"

unset SSH_HOST_KEY
