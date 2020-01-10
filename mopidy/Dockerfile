ARG BUILD_FROM=hassioaddons/debian-base:2.0.1
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
        dirmngr \
        gpg-agent \
        gpg \
        libnginx-mod-http-lua \
        luarocks \
        nginx \
        git \
    \
    && curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add - \
    && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        libasound2-dev \
        libspotify12 \
        libspotify-dev \
        zlib1g-dev \
        build-essential \
        python3-dev \
        python3-gi \
        python3-gst-1.0 \
        gstreamer1.0-alsa \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-pulseaudio \
        gstreamer1.0-tools \
    \
    && luarocks install lua-resty-http 0.13-0 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt \
    \
    && find /usr/local/lib/python3.7/ -type d -name tests -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.7/ -type d -name test -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.7/ -name __pycache__ -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.7/ -name "*.pyc" -depth -exec rm -f {} \; \
    \
    && apt-get purge -y --auto-remove \
        dirmngr \
        gpg-agent \
        gpg \
        git \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        build-essential \
        gcc \
        python-dev \
        dpkg-dev \
        gcc-7 \
        luarocks \
    && rm -fr \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
        /root/.cache \
    && find /tmp/ -mindepth 1  -delete

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
