FROM python:2.7-alpine

LABEL maintainer "flaudisio@gmail.com"

RUN apk add --no-cache \
        git \
        gcc \
        libffi-dev \
        make \
        musl-dev \
        openssh-client \
        openssl-dev

ARG ansible_version
ENV ANSIBLE_VERSION ${ansible_version:-2.3.1.0}

RUN pip install --no-cache-dir \
        "ansible == $ANSIBLE_VERSION" \
        'pywinrm >= 0.2.2, < 0.3'

COPY install-ssh-key.sh /usr/local/bin/install-ssh-key
COPY install-host-key.sh /usr/local/bin/install-host-key

CMD ["ansible", "--version"]
