#!/bin/sh

if [[ -z "$1" ]];then
    PKG_DIR="."
else
    PKG_DIR="$1"
fi


get_ver() {
  pushd "$PKG_DIR" 2>&1>/dev/null

  if [[ -d .hg ]];then
    printf "r%s.%s\n" "$(hg identify -n)" "$(hg identify -i)"
  elif [[ -d .git ]];then
    ( set -o pipefail
#        git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
#        printf "r%s.%s\n" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
        printf "%s_%s\n" "$(git log -1 --pretty='format:%cd' --date=format:'%Y%m%d' HEAD)" "$(git rev-parse --short=7 HEAD)"
    )
  elif [[ -d .svn ]];then
  local ver="$(svnversion)"
      printf "r%s\n" "${ver//[[:alpha:]]}"
  fi

  popd 2>&1>/dev/null
}

get_ver
