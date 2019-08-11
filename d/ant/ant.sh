#!/bin/sh
export ANT_HOME=/usr/share/ant
if ! echo $PATH | grep -q $ANT_HOME ; then
  export PATH="${PATH}:${ANT_HOME}/bin"
fi
