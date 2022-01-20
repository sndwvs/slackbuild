#!/bin/bash



fix_default() {
    for sb in $(find . -maxdepth 3 -type f | grep .SlackBuild);do
        psb=$(echo $sb | rev | cut -f2- -d '/' | rev)
        pf=$(basename "$sb")
        echo "$sb"
        sed '0,/^elif \[ "$ARCH" = "\(x86_64\|arm.*\)" \].*$/s/^elif \[ "$ARCH" = "\(x86_64\|arm.*\)" \].*$/elif \[ \"\$ARCH\" = \"aarch64\" \]; then\
  SLKCFLAGS=\"-O2 -fPIC\"\
  LIBDIRSUFFIX=\"64\"\n&/g' -i".aarch64" "${sb}"
    done
}

fix_default
