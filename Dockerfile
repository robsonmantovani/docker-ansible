FROM python:2.7-alpine

LABEL maintainer "flaudisio@gmail.com"

RUN apk add --no-cache \
        ca-certificates \
        curl \
        git \
        openssh-client

ARG ansible_version
ENV ANSIBLE_VERSION ${ansible_version:-2.3.2.0}

RUN apk add --no-cache --virtual .build-deps \
        gcc \
        libffi-dev \
        make \
        musl-dev \
        openssl-dev && \
    pip install --no-cache-dir \
        "ansible == $ANSIBLE_VERSION" \
        "pywinrm >= 0.2.2, < 0.3" && \
    apk del --purge .build-deps

COPY install-ssh-key.sh /usr/local/bin/install-ssh-key
COPY install-host-key.sh /usr/local/bin/install-host-key

CMD ["ansible", "--version"]
