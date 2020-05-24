#!/bin/bash

# Allow users to override command-line options
# Based on Gentoo's chromium package (and by extension, Debian's)
for FILE in /etc/chromium/*.conf ; do
  [[ -f ${FILE} ]] && source "${FILE}"
done

# Prefer user defined @CRUSERFLAGS@ flags (from environment) over
# system default @CRFLAGS@ (from /etc/chromium)/)
@CRFLAGS@=${@CRUSERFLAGS@:-$@CRFLAGS@}

export CHROME_WRAPPER=$(readlink -f "$0")
export CHROME_DESKTOP=chromium.desktop

exec /usr/lib@LIBDIRSUFFIX@/chromium/chromium $@CRFLAGS@ "$@"

