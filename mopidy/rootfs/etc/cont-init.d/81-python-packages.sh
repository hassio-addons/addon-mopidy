#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Mopidy
# Install user configured/requested Python packages
# ==============================================================================
if bashio::config.has_value 'python_packages'; then
    for package in $(bashio::config 'python_packages'); do
        pip install "$package" \
            || bashio::exit.nok "Failed installing package ${package}"
    done
fi
