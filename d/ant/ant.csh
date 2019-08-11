#!/bin/csh
setenv ANT_HOME /usr/share/ant
echo $PATH | grep -q $ANT_HOME
if ($status != 0) then
  setenv PATH ${PATH}:${ANT_HOME}/bin
endif
