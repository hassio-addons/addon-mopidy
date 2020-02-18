#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Mopidy
# Install user configured/requested packages
# ==============================================================================
if bashio::config.has_value 'system_packages'; then
    apt update \
        || bashio::exit.nok 'Failed updating Ubuntu packages repository indexes'

    for package in $(bashio::config 'system_packages'); do
        apt install -y "$package" \
            || bashio::exit.nok "Failed installing package ${package}"
    done
fi
