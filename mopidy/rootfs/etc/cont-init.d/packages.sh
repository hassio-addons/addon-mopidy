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

if bashio::config.has_value 'python_packages'; then
    for package in $(bashio::config 'python_packages'); do
        pip install "$package" \
            || bashio::exit.nok "Failed installing package ${package}"
    done
fi
