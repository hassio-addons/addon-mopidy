#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Mopidy
# Ensures needed folder exists.
# ==============================================================================
readonly MEDIA_DIR="/share/mopidy/media"

if ! bashio::fs.directory_exists "${MEDIA_DIR}"; then
  mkdir -p "${MEDIA_DIR}" || bashio::exit.nok "Could not create media folder: ${MEDIA_DIR}"
fi
