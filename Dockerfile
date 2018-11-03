FROM alpine:3.8

ARG GPLAYCLI_VERSION=3.25

RUN set -x \
    && apk add \
        build-base \
        gcc \
        libffi-dev \
        libxml2 \
        libxml2-dev \
        libxslt \
        libxslt-dev \
        openssl-dev \
        python3 \
        python3-dev \
    && pip3 install \
        gplaycli==${GPLAYCLI_VERSION} \
        setuptools \
        wheel \
    && apk del \
        build-base \
        gcc \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        openssl-dev \
        python3-dev \
    && rm -rf \
        /root/.cache/pip \
        /var/cache/apk/* \
    && find /usr/ -type d -name '__pycache__' | xargs rm -rf

COPY gplaycli.conf /root/.config/gplaycli/gplaycli.conf

COPY cache.json /tmp/gplaycli/token

WORKDIR /mnt

ENTRYPOINT ["/usr/bin/gplaycli"]
