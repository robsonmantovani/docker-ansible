#!/bin/sh

set -e

KeyFile="$HOME/.ssh/id_rsa"

if [ -n "$1" ] ; then
    SSH_PRIVATE_KEY="$1"
elif [ -n "$SSH_PRIVATE_KEY" ] ; then
    echo "Variável de ambiente SSH_PRIVATE_KEY detectada."
else
    echo "Fatal: nenhuma chave SSH privada definida." >&2
    exit 1
fi

mkdir -p -m 700 ~/.ssh

echo "Instalando chave privada SSH."

echo "$SSH_PRIVATE_KEY" > "$KeyFile"

chmod 600 "$KeyFile"

unset SSH_PRIVATE_KEY
