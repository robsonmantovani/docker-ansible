#!/usr/bin/env bash

set -e

DockerRepo="flaudisio/ansible"

SupportedVersions=(
    2.2.3.0:2.2
    2.3.0.0
    2.3.1.0:2.3
    2.3.1.0:latest
)

run_cmd()
{
    echo "+ $*"
    bash -c "$*"
}

pull_base_image()
{
    run_cmd docker pull $( grep '^FROM' Dockerfile | awk '{ print $2 }' )
}

build_images()
{
    local version
    local ansible_version
    local extra_tag

    for version in "${SupportedVersions[@]}" ; do
        ansible_version="${version%%:*}"
        extra_tag="${version##*:}"

        run_cmd docker build \
            --build-arg "ansible_version=$ansible_version" \
            --tag "$DockerRepo:$ansible_version" \
            .

        run_cmd docker run --rm "$DockerRepo:$ansible_version" ansible --version

        if [[ -n "$extra_tag" ]] ; then
            run_cmd docker tag "$DockerRepo:$ansible_version" "$DockerRepo:$extra_tag"
            run_cmd docker run --rm "$DockerRepo:$extra_tag" ansible --version
        fi
    done
}

main()
{
    if [[ "$1" == "--clean-before" ]] ; then
        run_cmd docker rmi $( docker image ls | egrep "^$DockerRepo" | awk '{ print $1":"$2 }' | sort ) || true
    fi

    pull_base_image
    build_images
}

main "$@"
