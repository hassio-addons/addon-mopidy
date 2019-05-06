ARG BUILD_FROM=hassioaddons/ubuntu-base:3.1.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        dirmngr=2.2.4-1ubuntu1.2 \
        gpg-agent=2.2.4-1ubuntu1.2 \
        gpg=2.2.4-1ubuntu1.2 \
        libnginx-mod-http-lua=1.14.0-0ubuntu1.2 \
        luarocks=2.4.2+dfsg-1 \
        nginx=1.14.0-0ubuntu1.2 \
    \
    && curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add - \
    && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        gstreamer1.0-alsa=1.14.1-1ubuntu1~ubuntu18.04.2 \
        gstreamer1.0-plugins-bad=1.14.1-1ubuntu1~ubuntu18.04.1 \
        gstreamer1.0-pulseaudio=1.14.1-1ubuntu1~ubuntu18.04.1 \
        libffi-dev=3.2.1-8 \
        libxml2-dev=2.9.4+dfsg1-6.1ubuntu1.2 \
        libxslt1-dev=1.1.29-5ubuntu0.1 \
        mopidy-alsamixer=1.0.3-3 \
        mopidy-local-sqlite=1.0.0-2 \
        mopidy-spotify-tunigo=1.0.0-0mopidy1 \
        mopidy-spotify=3.1.0-0mopidy1 \
        mopidy=2.2.2-1 \
        python-dev=2.7.15~rc1-1 \
        zlib1g-dev=1:1.2.11.dfsg-0ubuntu2 \
    \
    && luarocks install lua-resty-http 0.13-0 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python \
    && pip install --no-cache-dir -r /tmp/requirements.txt \
    \
    && find /usr/local/lib/python2.7/ -type d -name tests -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python2.7/ -type d -name test -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python2.7/ -name __pycache__ -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python2.7/ -name "*.pyc" -depth -exec rm -f {} \; \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        dirmngr \
        dpkg-dev \
        gcc \
        gcc-7 \
        gpg \
        gpg-agent \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        luarocks \
        python-dev \
        zlib1g-dev \
    \
    && find /tmp/ -mindepth 1  -delete \
    && rm -fr \
        /etc/nginx \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
        /root/.cache \
    \
    && mkdir -p /var/log/nginx \
    && touch /var/log/nginx/error.log

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Mopidy" \
    io.hass.description="Mopidy is an extensible music server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Bram Mittendorff, Franck Nijhof, Robbert Müller" \
    org.label-schema.description="Mopidy is an extensible music server" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Mopidy" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-mopidy/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-mopidy" \
    org.label-schema.vendor="Community Hass.io Add-ons"
