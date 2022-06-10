ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:6.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
RUN \
    mkdir -p /usr/local/share/keyrings \
    && curl -L https://apt.mopidy.com/mopidy.gpg -o /usr/local/share/keyrings/mopidy-archive-keyring.gpg \
    && curl -L https://apt.mopidy.com/mopidy.list -o /etc/apt/sources.list.d/mopidy.list \
    \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        build-essential=12.9 \
        git=1:2.30.2-1 \
        gstreamer1.0-alsa=1.18.4-2 \
        gstreamer1.0-plugins-bad=1.18.4-3 \
        gstreamer1.0-plugins-good=1.18.4-2 \
        gstreamer1.0-plugins-ugly=1.18.4-2 \
        gstreamer1.0-pulseaudio=1.18.4-2 \
        libasound2-dev=1.2.4-1.1 \
        libffi-dev=3.3-6 \
        libspotify-dev=12.1.51-1 \
        libspotify12=12.1.51-1 \
        libxml2-dev=2.9.10+dfsg-6.7+deb11u2 \
        libxslt1-dev=1.1.34-4 \
        nginx=1.18.0-6.1 \
        python3-dev=3.9.2-3 \
        python3-gi=3.38.0-2 \
        python3-gst-1.0=1.18.3-1 \
        zlib1g-dev=1:1.2.11.dfsg-2+deb11u1 \
        mopidy=3.3.0-1 \
        mopidy-alsamixer=2.0.1-1 \
        mopidy-local=3.2.1-1 \
        mopidy-mpd=3.3.0-1 \
        mopidy-podcast=3.0.1-1 \
        mopidy-soundcloud=3.0.1-1 \
        mopidy-tunein=1.1.0-1 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && apt-get purge -y --auto-remove \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        build-essential \
        gcc \
        python-dev \
        dpkg-dev \
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
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Bram Mittendorff, Franck Nijhof, Robbert Müller" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Bram Mittendorff, Franck Nijhof, Robbert Müller" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
