#!/bin/sh

# Copyright 2012  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# scripts are taken as a basis:
# Willy Sudiarto Raharjo https://github.com/CinnamonSlackBuilds/csb/blob/master/build-cinnamon.sh
# Ryan McQuen https://github.com/ryanpcmcquen/slackENLIGHTENMENT/blob/master/enlighten-me.sh
#

INSTALL=yes

TMP=${TMP:-/tmp/enlightenment}
OUTPUT=${OUTPUT:-/tmp/enlightenment}

ENLIGHTENMENT_ROOT=$(pwd)

# Loop for all packages
for dir in \
  lua \
  luajit \
  bullet \
  efl \
  python-efl \
  enlightenment \
  terminology \
  ; do
  # Get the package name
  package=$(echo $dir | cut -f2- -d /)

  # Change to package directory
  cd $ENLIGHTENMENT_ROOT/$dir || exit 1

  # Get the version
  version=$(cat ${package}.SlackBuild | grep "VERSION:" | head -n1 | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # Get the build
  build=$(cat ${package}.SlackBuild | grep "BUILD:" | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # The real build starts here
  TMP=$TMP OUTPUT=$OUTPUT sh ${package}.SlackBuild || exit 1
  if [[ "$INSTALL" == yes ]]; then
    PACKAGE=$(ls $OUTPUT/${package}-${version}-*-${build}*.txz)
    if [ -f "$PACKAGE" ]; then
      upgradepkg --install-new --reinstall "$PACKAGE"
    else
      echo "Error:  package to upgrade "$PACKAGE" not found in $OUTPUT"
      exit 1
    fi
  fi

  # back to original directory
  cd $ENLIGHTENMENT_ROOT
done
