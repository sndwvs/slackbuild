#!/bin/bash

# source: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=ffmpeg-v4l2-request-git

NAME="ffmpeg-v4l2-request"
SOURCE="https://github.com/jernejsk/FFmpeg.git"
_version='5.1.2'
_branch1='v4l2-request-n'${_version}
_branch2='v4l2-drmprime-n'${_version}
_branch3='vf-deinterlace-v4l2m2m-n'${_version}

git clone $SOURCE -b ${_branch1} $NAME || exit 1

cd $NAME || exit 1
git reset --hard
git checkout ${_branch1}
if [ ! -z ${_branch2} ]; then
    git -c "user.name=Your Name" -c "user.email=you@example.com" \
    merge --no-edit origin/${_branch2}
fi
if [ ! -z ${_branch3} ]; then
    git -c "user.name=Your Name" -c "user.email=you@example.com" \
    merge --no-edit origin/${_branch3}
fi

VERSION=$(printf "%s_%s\n" "$(git log -1 --pretty='format:%cd' --date=format:'%Y%m%d' HEAD)" "$(git rev-parse --short=7 HEAD)")

cd ..
mv $NAME $NAME-$VERSION || exit 1
tar cJf $NAME-$VERSION.tar.xz $NAME-$VERSION || exit 1

