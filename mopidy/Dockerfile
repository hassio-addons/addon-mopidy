ARG BUILD_FROM=hassioaddons/debian-base:3.0.1
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
        dirmngr=2.2.12-1+deb10u1 \
        gpg-agent=2.2.12-1+deb10u1 \
        gpg=2.2.12-1+deb10u1 \
        libnginx-mod-http-lua=1.14.2-2+deb10u1 \
        luarocks=2.4.2+dfsg-1 \
        nginx=1.14.2-2+deb10u1 \
        git=1:2.20.1-2+deb10u1 \
    \
    && curl -L https://apt.mopidy.com/mopidy.gpg | apt-key add - \
    && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        libffi-dev=3.2.1-9 \
        libxml2-dev=2.9.4+dfsg1-7+b3 \
        libxslt1-dev=1.1.32-2.2~deb10u1 \
        libasound2-dev=1.1.8-1 \
        libspotify12=12.1.51-1 \
        libspotify-dev=12.1.51-1 \
        zlib1g-dev=1:1.2.11.dfsg-1 \
        build-essential=12.6 \
        python3-dev=3.7.3-1 \
        python3-gi=3.30.4-1 \
        python3-gst-1.0=1.14.4-1+b1 \
        gstreamer1.0-alsa=1.14.4-2 \
        gstreamer1.0-plugins-bad=1.14.4-1+b1 \
        gstreamer1.0-plugins-good=1.14.4-1 \
        gstreamer1.0-plugins-ugly=1.14.4-1 \
        gstreamer1.0-pulseaudio=1.14.4-1 \
    \
    && luarocks install lua-resty-http 0.15-0 \
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

# Move access.log to stdout and error.log to stderr
RUN mkdir -p /var/log/nginx && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

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
    org.label-schema.vendor="Home Assistant Community Add-ons"
