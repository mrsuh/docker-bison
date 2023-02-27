FROM debian:bullseye-slim

LABEL maintainer="mrsuh6@gmail.com"

ENV BISON_VERSION v3.8.2
ENV AUTOCONF_VERSION 2.71

RUN set -eux; \
    mkdir -p /usr/src; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        automake \
        autopoint \
        ca-certificates \
        flex \
        gettext \
        gcc \
        git \
        gperf \
        graphviz \
        help2man \
        libc6-dev \
        m4 \
        make \
        texinfo \
        wget \
        xsltproc; \
    \
	wget ftp://ftp.gnu.org/gnu/autoconf/autoconf-$AUTOCONF_VERSION.tar.gz; \
	tar -xvzf autoconf-$AUTOCONF_VERSION.tar.gz; \
    cd /autoconf-$AUTOCONF_VERSION; \
	./configure; \
	make; \
	make install; \
	make clean; \
	rm -rf /autoconf-$AUTOCONF_VERSION.tar.gz; \
	rm -rf /autoconf-$AUTOCONF_VERSION; \
	cd /; \
    \
	git clone --branch=$BISON_VERSION --depth=1 https://github.com/akimd/bison.git /bison; \
	cd /bison; \
	git submodule update --init --recursive; \
	./bootstrap; \
	./configure; \
	make; \
	make install; \
	make clean; \
	rm -rf /bison; \
	cd /; \
    \
    apt-mark auto '.*' > /dev/null; \
    apt-mark manual m4 > /dev/null; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
