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

CMD ["ansible", "--version"]
