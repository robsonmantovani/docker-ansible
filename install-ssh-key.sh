#!/bin/sh

set -e

KeyFile="$HOME/.ssh/id_rsa"

run_cmd()
{
    (
        set -x
        "$@"
    )
}

run_cmd mkdir -p -m 700 ~/.ssh

echo "+ echo '<KEY>' > $KeyFile"

echo "$*" > "$KeyFile"

run_cmd chmod 600 "$KeyFile"
