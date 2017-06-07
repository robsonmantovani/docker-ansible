FROM python:2.7-alpine

LABEL maintainer "flaudisio@gmail.com"

RUN apk add --no-cache \
        git \
        gcc \
        libffi-dev \
        musl-dev \
        openssh-client \
        openssl-dev

RUN pip install --no-cache-dir \
        'ansible >=2.2,<2.3' \
        'pywinrm >=0.2.2'

COPY install-ssh-key.sh /usr/local/bin/install-ssh-key
COPY install-host-key.sh /usr/local/bin/install-host-key

CMD ["ansible", "--version"]
