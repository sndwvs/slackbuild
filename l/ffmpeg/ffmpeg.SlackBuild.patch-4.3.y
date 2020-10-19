--- a/ffmpeg.SlackBuild	2018-09-07 19:58:43.316256787 +0300
+++ b/ffmpeg.SlackBuild	2018-09-07 19:59:39.129059019 +0300
@@ -54,6 +54,12 @@
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
@@ -153,6 +159,10 @@
 # No default patent encumbered features:
 aac=""        ; [ "${AAC:-no}" = "no" ]           && aac="--disable-encoder=aac"
 
+# add support rockchip mpp
+libdrm=""    ; [ "${LIBDRM:-yes}" != "no" ]       && libdrm="--enable-libdrm"
+rkmpp=""     ; [ "${RKMPP:-yes}" != "no" ]        && rkmpp="--enable-rkmpp"
+
 rm -rf $PKG
 mkdir -p $TMP $PKG
 cd $TMP
@@ -241,7 +251,9 @@
   $samba \
   $ssl \
   $tesseract \
-  $wavpack || exit 1
+  $wavpack \
+  $libdrm \
+  $rkmpp || exit 1
 
 make $NUMJOBS || make || exit 1
 make install DESTDIR=$PKG || exit 1
