--- ffmpeg.SlackBuild.orig	2021-10-26 21:15:38.915153948 +0300
+++ ffmpeg.SlackBuild	2021-10-30 12:46:59.996712915 +0300
@@ -31,6 +31,7 @@
 PKGNAM=ffmpeg
 VERSION=${VERSION:-$(echo $PKGNAM-*.tar.xz | rev | cut -f 3- -d . | cut -f 1 -d - | rev)}
 BUILD=${BUILD:-2}
+FAMILY=${FAMILY:-}
 
 if [ -z "$ARCH" ]; then
   case "$( uname -m )" in
@@ -54,6 +55,12 @@
 elif [ "$ARCH" = "x86_64" ]; then
   SLKCFLAGS="-O2 -fPIC"
   LIBDIRSUFFIX="64"
+elif [ "$ARCH" = "arm" ]; then
+  SLKCFLAGS="-O3 -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
+  LIBDIRSUFFIX=""
+elif [ "$ARCH" = "aarch64" ]; then
+  SLKCFLAGS="-O3"
+  LIBDIRSUFFIX="64"
 else
   SLKCFLAGS="-O2"
   LIBDIRSUFFIX=""
@@ -167,6 +174,9 @@
 # No default patent encumbered features:
 aac=""        ; [ "${AAC:-no}" = "no" ]           && aac="--disable-encoder=aac"
 
+# add support rockchip mpp
+rkmpp=""     ; [ "${RKMPP:-yes}" != "no" ]        && rkmpp="--enable-rkmpp"
+
 rm -rf $PKG
 mkdir -p $TMP $PKG
 cd $TMP
@@ -181,6 +191,8 @@
  \( -perm 666 -o -perm 664 -o -perm 640 -o -perm 600 -o -perm 444 \
   -o -perm 440 -o -perm 400 \) -exec chmod 644 {} \+
 
+[[ ! -z ${FAMILY} ]] && FAMILY="-${FAMILY}"
+
 # Fix linking with flite:
 sed -i "s| -lflite\"| -lflite -lm -lasound\"|" \
   ./configure
@@ -268,7 +280,8 @@
   $libsoxr \
   $libsrt \
   $libzimg \
-  $vapoursynth || exit 1
+  $vapoursynth \
+  $rkmpp || exit 1
 
 make $NUMJOBS || make || exit 1
 make install DESTDIR=$PKG || exit 1
@@ -296,7 +309,8 @@
 fi
 
 mkdir -p $PKG/install
-cat $CWD/slack-desc > $PKG/install/slack-desc
+# fixed slack-desc
+cat $CWD/slack-desc | sed "s#^${PKGNAM}#${PKGNAM}${FAMILY}#g" > $PKG/install/slack-desc
 
 cd $PKG
-/sbin/makepkg -l y -c n $TMP/$PKGNAM-$VERSION-$ARCH-$BUILD$TAG.txz
+/sbin/makepkg -l y -c n $TMP/$PKGNAM${FAMILY}-$VERSION-$ARCH-$BUILD$TAG.txz
