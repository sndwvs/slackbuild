#!/bin/sh

if [[ -z "$1" ]];then
    PKG_DIR="."
else
    PKG_DIR="$1"
fi


get_ver() {
  pushd "$PKG_DIR" 2>&1>/dev/null

  if [[ -d .hg ]];then
    printf "r%s.%s" "$(hg identify -n)" "$(hg identify -i)"
  elif [[ -d .git ]];then
    ( set -o pipefail
        git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
        printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    )
  elif [[ -d .svn ]];then
  local ver="$(svnversion)"
      printf "r%s" "${ver//[[:alpha:]]}"
  fi

  popd 2>&1>/dev/null
}

get_ver
