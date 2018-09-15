--- a/gcc.SlackBuild	2018-06-26 08:50:43.921051408 +0300
+++ b/gcc.SlackBuild	2018-09-12 19:34:22.181450229 +0300
@@ -115,6 +115,14 @@
   SLKCFLAGS="-O3 -march=armv7-a -mfpu=vfpv3-d16"
   LIBDIRSUFFIX=""
   LIB_ARCH=armv7hl
+elif [ "$ARCH" = "arm" ]; then
+  SLKCFLAGS="-O3 -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
+  LIBDIRSUFFIX=""
+  LIB_ARCH=$ARCH
+elif [ "$ARCH" = "aarch64" ]; then
+  SLKCFLAGS="-O2"
+  LIBDIRSUFFIX="64"
+  LIB_ARCH=aarch64
 else
   SLKCFLAGS="-O2"
   LIBDIRSUFFIX=""
@@ -122,7 +130,7 @@
 fi
 
 case "$ARCH" in
-    arm*) TARGET=$ARCH-slackware-linux-gnueabi ;;
+    arm*) TARGET=$ARCH-slackware-linux-gnueabihf ;;
     *)    TARGET=$ARCH-slackware-linux ;;
 esac
 
@@ -138,12 +146,12 @@
 PKG1=$TMP/package-gcc
 # These are the directories to build other packages in:
 PKG2=$TMP/package-gcc-g++
-PKG3=$TMP/package-gcc-gfortran
-PKG4=$TMP/package-gcc-gnat
-PKG6=$TMP/package-gcc-objc
+#PKG3=$TMP/package-gcc-gfortran
+#PKG4=$TMP/package-gcc-gnat
+#PKG6=$TMP/package-gcc-objc
 #PKG7=$TMP/package-gcc-g++-gch
-PKG8=$TMP/package-gcc-go
-PKG9=$TMP/package-gcc-brig
+#PKG8=$TMP/package-gcc-go
+#PKG9=$TMP/package-gcc-brig
 
 # Clear the build locations:
 rm -rf $TMP/gcc.build.lnx
@@ -154,12 +162,12 @@
 mkdir -p $PKG{1,2,3,4,6,8,9}/install
 cat $CWD/slack-desc.gcc > $PKG1/install/slack-desc
 cat $CWD/slack-desc.gcc-g++ > $PKG2/install/slack-desc
-cat $CWD/slack-desc.gcc-gfortran > $PKG3/install/slack-desc
-cat $CWD/slack-desc.gcc-gnat > $PKG4/install/slack-desc
-cat $CWD/slack-desc.gcc-objc > $PKG6/install/slack-desc
+#cat $CWD/slack-desc.gcc-gfortran > $PKG3/install/slack-desc
+#cat $CWD/slack-desc.gcc-gnat > $PKG4/install/slack-desc
+#cat $CWD/slack-desc.gcc-objc > $PKG6/install/slack-desc
 #cat $CWD/slack-desc.gcc-g++-gch > $PKG7/install/slack-desc
-cat $CWD/slack-desc.gcc-go > $PKG8/install/slack-desc
-cat $CWD/slack-desc.gcc-brig > $PKG9/install/slack-desc
+#cat $CWD/slack-desc.gcc-go > $PKG8/install/slack-desc
+#cat $CWD/slack-desc.gcc-brig > $PKG9/install/slack-desc
 
 ( cd gcc-$SRCVER || exit 1
 
@@ -199,92 +207,92 @@
       ABOUT* COPYING* DATESTAMP DEV-PHASE LANG* ONEWS README* SERVICE \
     $PKG1/usr/doc/gcc-$VERSION/gcc
          
-    mkdir -p $PKG3/usr/doc/gcc-${VERSION}/gcc/fortran
-    ( cd fortran || exit 0
-      if [ -r ChangeLog ]; then
-        cat ChangeLog | head -n 1000 > $PKG3/usr/doc/gcc-$VERSION/gcc/fortran/ChangeLog
-        touch -r ChangeLog $PKG3/usr/doc/gcc-$VERSION/gcc/fortran/ChangeLog
-      fi
-    )
-
-    mkdir -p $PKG4/usr/doc/gcc-${VERSION}/gcc/ada
-    ( cd ada || exit 0
-      cp -a \
-        ChangeLog.tree-ssa \
-      $PKG4/usr/doc/gcc-$VERSION/gcc/ada
-      if [ -r ChangeLog ]; then
-        cat ChangeLog | head -n 1000 > $PKG4/usr/doc/gcc-$VERSION/gcc/ada/ChangeLog
-        touch -r ChangeLog $PKG4/usr/doc/gcc-$VERSION/gcc/ada/ChangeLog
-      fi
-    )
-
-    mkdir -p $PKG6/usr/doc/gcc-${VERSION}/gcc/objc
-    ( cd objc || exit 0
-      cp -a \
-        README* \
-      $PKG6/usr/doc/gcc-${VERSION}/gcc/objc
-      if [ -r ChangeLog ]; then
-        cat ChangeLog | head -n 1000 > $PKG6/usr/doc/gcc-${VERSION}/gcc/objc/ChangeLog
-        touch -r ChangeLog $PKG6/usr/doc/gcc-${VERSION}/gcc/objc/ChangeLog
-      fi
-    )
-
-    mkdir -p $PKG8/usr/doc/gcc-${VERSION}/gcc/go
-    ( cd go || exit 0
-      if [ -r ChangeLog ]; then
-        cat ChangeLog | head -n 1000 > $PKG8/usr/doc/gcc-${VERSION}/gcc/go/ChangeLog
-        touch -r ChangeLog $PKG8/usr/doc/gcc-${VERSION}/gcc/go/ChangeLog
-      fi
-      cp -a \
-        README* THREADS* \
-        gofrontend/{LICENSE,PATENTS,README} \
-      $PKG8/usr/doc/gcc-${VERSION}/gcc/go
-    )
-
-    mkdir -p $PKG9/usr/doc/gcc-${VERSION}/gcc/brig
-    ( cd brig || exit 0
-      if [ -r ChangeLog ]; then
-        cat ChangeLog | head -n 1000 > $PKG9/usr/doc/gcc-${VERSION}/gcc/brig/ChangeLog
-        touch -r ChangeLog $PKG9/usr/doc/gcc-${VERSION}/gcc/brig/ChangeLog
-      fi
-    )
+#    mkdir -p $PKG3/usr/doc/gcc-${VERSION}/gcc/fortran
+#    ( cd fortran || exit 0
+#      if [ -r ChangeLog ]; then
+#        cat ChangeLog | head -n 1000 > $PKG3/usr/doc/gcc-$VERSION/gcc/fortran/ChangeLog
+#        touch -r ChangeLog $PKG3/usr/doc/gcc-$VERSION/gcc/fortran/ChangeLog
+#      fi
+#    )
+
+#    mkdir -p $PKG4/usr/doc/gcc-${VERSION}/gcc/ada
+#    ( cd ada || exit 0
+#      cp -a \
+#        ChangeLog.tree-ssa \
+#      $PKG4/usr/doc/gcc-$VERSION/gcc/ada
+#      if [ -r ChangeLog ]; then
+#        cat ChangeLog | head -n 1000 > $PKG4/usr/doc/gcc-$VERSION/gcc/ada/ChangeLog
+#        touch -r ChangeLog $PKG4/usr/doc/gcc-$VERSION/gcc/ada/ChangeLog
+#      fi
+#    )
+
+#    mkdir -p $PKG6/usr/doc/gcc-${VERSION}/gcc/objc
+#    ( cd objc || exit 0
+#      cp -a \
+#        README* \
+#      $PKG6/usr/doc/gcc-${VERSION}/gcc/objc
+#      if [ -r ChangeLog ]; then
+#        cat ChangeLog | head -n 1000 > $PKG6/usr/doc/gcc-${VERSION}/gcc/objc/ChangeLog
+#        touch -r ChangeLog $PKG6/usr/doc/gcc-${VERSION}/gcc/objc/ChangeLog
+#      fi
+#    )
+
+#    mkdir -p $PKG8/usr/doc/gcc-${VERSION}/gcc/go
+#    ( cd go || exit 0
+#      if [ -r ChangeLog ]; then
+#        cat ChangeLog | head -n 1000 > $PKG8/usr/doc/gcc-${VERSION}/gcc/go/ChangeLog
+#        touch -r ChangeLog $PKG8/usr/doc/gcc-${VERSION}/gcc/go/ChangeLog
+#      fi
+#      cp -a \
+#        README* THREADS* \
+#        gofrontend/{LICENSE,PATENTS,README} \
+#      $PKG8/usr/doc/gcc-${VERSION}/gcc/go
+#    )
+
+#    mkdir -p $PKG9/usr/doc/gcc-${VERSION}/gcc/brig
+#    ( cd brig || exit 0
+#      if [ -r ChangeLog ]; then
+#        cat ChangeLog | head -n 1000 > $PKG9/usr/doc/gcc-${VERSION}/gcc/brig/ChangeLog
+#        touch -r ChangeLog $PKG9/usr/doc/gcc-${VERSION}/gcc/brig/ChangeLog
+#      fi
+#    )
 
   ) || exit 1
 
-  mkdir -p $PKG3/usr/doc/gcc-${VERSION}/libgfortran
-  ( cd libgfortran || exit 0
-    if [ -r ChangeLog ]; then
-      cat ChangeLog | head -n 1000 > $PKG3/usr/doc/gcc-${VERSION}/libgfortran/ChangeLog
-      touch -r ChangeLog $PKG3/usr/doc/gcc-${VERSION}/libgfortran/ChangeLog
-    fi
-  )
-
-  mkdir -p $PKG4/usr/doc/gcc-${VERSION}/libada
-  ( cd libada || exit 0
-    if [ -r ChangeLog ]; then
-      cat ChangeLog | head -n 1000 > $PKG4/usr/doc/gcc-${VERSION}/libada/ChangeLog
-      touch -r ChangeLog $PKG4/usr/doc/gcc-${VERSION}/libada/ChangeLog
-    fi
-  )
-
-  mkdir -p $PKG1/usr/doc/gcc-${VERSION}/libgomp
-  ( cd libgomp || exit 0
-    if [ -r ChangeLog ]; then
-      cat ChangeLog | head -n 1000 > $PKG1/usr/doc/gcc-${VERSION}/libgomp/ChangeLog
-      touch -r ChangeLog $PKG1/usr/doc/gcc-${VERSION}/libgomp/ChangeLog
-    fi
-  )
+#  mkdir -p $PKG3/usr/doc/gcc-${VERSION}/libgfortran
+#  ( cd libgfortran || exit 0
+#    if [ -r ChangeLog ]; then
+#      cat ChangeLog | head -n 1000 > $PKG3/usr/doc/gcc-${VERSION}/libgfortran/ChangeLog
+#      touch -r ChangeLog $PKG3/usr/doc/gcc-${VERSION}/libgfortran/ChangeLog
+#    fi
+#  )
+
+#  mkdir -p $PKG4/usr/doc/gcc-${VERSION}/libada
+#  ( cd libada || exit 0
+#    if [ -r ChangeLog ]; then
+#      cat ChangeLog | head -n 1000 > $PKG4/usr/doc/gcc-${VERSION}/libada/ChangeLog
+#      touch -r ChangeLog $PKG4/usr/doc/gcc-${VERSION}/libada/ChangeLog
+#    fi
+#  )
+
+#  mkdir -p $PKG1/usr/doc/gcc-${VERSION}/libgomp
+#  ( cd libgomp || exit 0
+#    if [ -r ChangeLog ]; then
+#      cat ChangeLog | head -n 1000 > $PKG1/usr/doc/gcc-${VERSION}/libgomp/ChangeLog
+#      touch -r ChangeLog $PKG1/usr/doc/gcc-${VERSION}/libgomp/ChangeLog
+#    fi
+#  )
   
-  mkdir -p $PKG6/usr/doc/gcc-${VERSION}/libobjc
-  ( cd libobjc || exit 0
-    if [ -r ChangeLog ]; then
-      cat ChangeLog | head -n 1000 > $PKG6/usr/doc/gcc-${VERSION}/libobjc/ChangeLog
-      touch -r ChangeLog $PKG6/usr/doc/gcc-${VERSION}/libobjc/ChangeLog
-    fi
-    cp -a \
-      README* THREADS* \
-    $PKG6/usr/doc/gcc-${VERSION}/libobjc
-  )
+#  mkdir -p $PKG6/usr/doc/gcc-${VERSION}/libobjc
+#  ( cd libobjc || exit 0
+#    if [ -r ChangeLog ]; then
+#      cat ChangeLog | head -n 1000 > $PKG6/usr/doc/gcc-${VERSION}/libobjc/ChangeLog
+#      touch -r ChangeLog $PKG6/usr/doc/gcc-${VERSION}/libobjc/ChangeLog
+#    fi
+#    cp -a \
+#      README* THREADS* \
+#    $PKG6/usr/doc/gcc-${VERSION}/libobjc
+#  )
     
   mkdir -p $PKG2/usr/doc/gcc-${VERSION}/libstdc++-v3
   ( cd libstdc++-v3 || exit 0
@@ -317,6 +325,8 @@
     GCC_ARCHOPTS="--disable-multilib"
   fi
  
+  [[ "$ARCH" =~ arm|aarch64 ]] && GCC_ARCHOPTS="--disable-multilib"
+
   CFLAGS="$SLKCFLAGS" \
   CXXFLAGS="$SLKCFLAGS" \
   ../gcc-$SRCVER/configure --prefix=/usr \
@@ -325,7 +335,7 @@
      --infodir=/usr/info \
      --enable-shared \
      --enable-bootstrap \
-     --enable-languages=ada,brig,c,c++,fortran,go,lto,objc \
+     --enable-languages=c,c++ \
      --enable-threads=posix \
      --enable-checking=release \
      --enable-objc-gc \
@@ -355,15 +365,15 @@
   # Include all debugging info (for now):
   make $NUMJOBS bootstrap || exit 1
 
-  ( cd gcc
-    make $NUMJOBS gnatlib GNATLIBCFLAGS="$SLKCFLAGS" || exit 1
+#  ( cd gcc
+#    make $NUMJOBS gnatlib GNATLIBCFLAGS="$SLKCFLAGS" || exit 1
     # This wants a shared -ladd2line?
     #make gnatlib-shared || exit 1
     
-    CFLAGS="$SLKCFLAGS" \
-    CXXFLAGS="$SLKCFLAGS" \
-    make $NUMJOBS gnattools || exit 1
-  ) || exit 1
+#    CFLAGS="$SLKCFLAGS" \
+#    CXXFLAGS="$SLKCFLAGS" \
+#    make $NUMJOBS gnattools || exit 1
+#  ) || exit 1
   make info || exit 1
 
   # Set GCCCHECK=something to run the tests
@@ -492,50 +502,50 @@
 )
 
 # gcc-gfortran:
-( cd $PKG3
-  mkdir -p usr/bin
-  mv $PKG1/usr/bin/*gfortran* usr/bin
-  mv $PKG1/usr/bin/*95* usr/bin
-  mv $PKG1/usr/bin/*77* usr/bin
-  # Doesn't this seem like a logical idea?
-  ( cd usr/bin ; ln -sf gfortran-gcc-${VERSION} fortran )
-  mkdir -p usr/info
-  mv $PKG1/usr/info/gfortran* usr/info
-  mkdir -p usr/lib${LIBDIRSUFFIX}
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/libgfortran* usr/lib${LIBDIRSUFFIX}
-  mkdir -p usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/finclude usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/libgfortran* usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
-  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/f951 usr/libexec/gcc/$TARGET/$VERSION/f951
-  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/libgfortran* usr/libexec/gcc/$TARGET/$VERSION
-  mkdir -p usr/man/man1
-  mv $PKG1/usr/man/man1/gfortran* usr/man/man1
-)
+#( cd $PKG3
+#  mkdir -p usr/bin
+#  mv $PKG1/usr/bin/*gfortran* usr/bin
+#  mv $PKG1/usr/bin/*95* usr/bin
+#  mv $PKG1/usr/bin/*77* usr/bin
+#  # Doesn't this seem like a logical idea?
+#  ( cd usr/bin ; ln -sf gfortran-gcc-${VERSION} fortran )
+#  mkdir -p usr/info
+#  mv $PKG1/usr/info/gfortran* usr/info
+#  mkdir -p usr/lib${LIBDIRSUFFIX}
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/libgfortran* usr/lib${LIBDIRSUFFIX}
+#  mkdir -p usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/finclude usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/libgfortran* usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
+#  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/f951 usr/libexec/gcc/$TARGET/$VERSION/f951
+#  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/libgfortran* usr/libexec/gcc/$TARGET/$VERSION
+#  mkdir -p usr/man/man1
+#  mv $PKG1/usr/man/man1/gfortran* usr/man/man1
+#)
 
 # gcc-gnat:
-( cd $PKG4
-  mkdir -p usr/bin
-  mv $PKG1/usr/bin/gnat* usr/bin
-  mv $PKG1/usr/bin/gpr* usr/bin
-  mkdir -p usr/info
-  mv $PKG1/usr/info/gnat* usr/info
-  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/gnat1 usr/libexec/gcc/$TARGET/$VERSION
-  mkdir -p usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/adainclude usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/adalib usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
-)
+#( cd $PKG4
+#  mkdir -p usr/bin
+#  mv $PKG1/usr/bin/gnat* usr/bin
+#  mv $PKG1/usr/bin/gpr* usr/bin
+#  mkdir -p usr/info
+#  mv $PKG1/usr/info/gnat* usr/info
+#  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/gnat1 usr/libexec/gcc/$TARGET/$VERSION
+#  mkdir -p usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/adainclude usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/adalib usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION
+#)
 
 # gcc-objc:
-( cd $PKG6
-  mkdir -p usr/lib${LIBDIRSUFFIX}
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/libobjc* usr/lib${LIBDIRSUFFIX}
-  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/cc1obj usr/libexec/gcc/$TARGET/$VERSION
-  mkdir -p usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/include
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/include/objc usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/include
-)
+#( cd $PKG6
+#  mkdir -p usr/lib${LIBDIRSUFFIX}
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/libobjc* usr/lib${LIBDIRSUFFIX}
+#  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/cc1obj usr/libexec/gcc/$TARGET/$VERSION
+#  mkdir -p usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/include
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/include/objc usr/lib${LIBDIRSUFFIX}/gcc/$TARGET/$VERSION/include
+#)
 
 ## NOTE: Thought about this, because the precompiled headers are so large.
 ## Probably easier to keep everything together, though.
@@ -546,55 +556,55 @@
 #)
 
 # gcc-go:
-( cd $PKG8
-  mkdir -p usr/bin
-  mv $PKG1/usr/bin/*gccgo* usr/bin
-  mv $PKG1/usr/bin/go{,fmt} usr/bin
-  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/{cgo,go1} usr/libexec/gcc/$TARGET/$VERSION
-  mkdir -p usr/info
-  mv $PKG1/usr/info/gccgo.info.gz usr/info
-  mkdir -p usr/lib${LIBDIRSUFFIX}
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/go usr/lib${LIBDIRSUFFIX}
-  if [ -r $PKG1/usr/lib${LIBDIRSUFFIX}/libgo.la ]; then
-    mv $PKG1/usr/lib${LIBDIRSUFFIX}/libgo.la usr/lib${LIBDIRSUFFIX}
-  fi
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/{libgo.so*,libgobegin.a,libgolibbegin.a} usr/lib${LIBDIRSUFFIX} || exit 1
-  # Don't package the (bloated) libgo.a. As a rule, we don't package static libraries.
-  rm -f $PKG1/usr/lib${LIBDIRSUFFIX}/libgo.a
-  mkdir -p usr/man/man1
-  mv $PKG1/usr/man/man1/gccgo.1.gz usr/man/man1
-  mv $PKG1/usr/man/man1/go.1.gz usr/man/man1
-  mv $PKG1/usr/man/man1/gofmt.1.gz usr/man/man1
-) || exit 1
+#( cd $PKG8
+#  mkdir -p usr/bin
+#  mv $PKG1/usr/bin/*gccgo* usr/bin
+#  mv $PKG1/usr/bin/go{,fmt} usr/bin
+#  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/{cgo,go1} usr/libexec/gcc/$TARGET/$VERSION
+#  mkdir -p usr/info
+#  mv $PKG1/usr/info/gccgo.info.gz usr/info
+#  mkdir -p usr/lib${LIBDIRSUFFIX}
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/go usr/lib${LIBDIRSUFFIX}
+#  if [ -r $PKG1/usr/lib${LIBDIRSUFFIX}/libgo.la ]; then
+#    mv $PKG1/usr/lib${LIBDIRSUFFIX}/libgo.la usr/lib${LIBDIRSUFFIX}
+#  fi
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/{libgo.so*,libgobegin.a,libgolibbegin.a} usr/lib${LIBDIRSUFFIX} || exit 1
+#  # Don't package the (bloated) libgo.a. As a rule, we don't package static libraries.
+#  rm -f $PKG1/usr/lib${LIBDIRSUFFIX}/libgo.a
+#  mkdir -p usr/man/man1
+#  mv $PKG1/usr/man/man1/gccgo.1.gz usr/man/man1
+#  mv $PKG1/usr/man/man1/go.1.gz usr/man/man1
+#  mv $PKG1/usr/man/man1/gofmt.1.gz usr/man/man1
+#) || exit 1
 
 # gcc-brig:
-( cd $PKG9
-  mkdir -p usr/bin
-  mv $PKG1/usr/bin/*brig* usr/bin
-  mkdir -p usr/lib${LIBDIRSUFFIX}
-  mv $PKG1/usr/lib${LIBDIRSUFFIX}/libhsail* usr/lib${LIBDIRSUFFIX}
-  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
-  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/brig1 usr/libexec/gcc/$TARGET/$VERSION
-  mkdir -p usr/man/man1
-  mv $PKG1/usr/man/man1/gccbrig.1.gz usr/man/man1
-)
+#( cd $PKG9
+#  mkdir -p usr/bin
+#  mv $PKG1/usr/bin/*brig* usr/bin
+#  mkdir -p usr/lib${LIBDIRSUFFIX}
+#  mv $PKG1/usr/lib${LIBDIRSUFFIX}/libhsail* usr/lib${LIBDIRSUFFIX}
+#  mkdir -p usr/libexec/gcc/$TARGET/$VERSION
+#  mv $PKG1/usr/libexec/gcc/$TARGET/$VERSION/brig1 usr/libexec/gcc/$TARGET/$VERSION
+#  mkdir -p usr/man/man1
+#  mv $PKG1/usr/man/man1/gccbrig.1.gz usr/man/man1
+#)
 
 # Generate packages:
 ( cd $PKG1
   makepkg -l y -c n $TMP/gcc-$VERSION-$ARCH-$BUILD.txz )
 ( cd $PKG2
   makepkg -l y -c n $TMP/gcc-g++-$VERSION-$ARCH-$BUILD.txz )
-( cd $PKG3
-  makepkg -l y -c n $TMP/gcc-gfortran-$VERSION-$ARCH-$BUILD.txz )
-( cd $PKG4
-  makepkg -l y -c n $TMP/gcc-gnat-$VERSION-$ARCH-$BUILD.txz )
-( cd $PKG6
-  makepkg -l y -c n $TMP/gcc-objc-$VERSION-$ARCH-$BUILD.txz )
-( cd $PKG8
-  makepkg -l y -c n $TMP/gcc-go-$VERSION-$ARCH-$BUILD.txz )
-( cd $PKG9
-  makepkg -l y -c n $TMP/gcc-brig-$VERSION-$ARCH-$BUILD.txz )
+#( cd $PKG3
+#  makepkg -l y -c n $TMP/gcc-gfortran-$VERSION-$ARCH-$BUILD.txz )
+#( cd $PKG4
+#  makepkg -l y -c n $TMP/gcc-gnat-$VERSION-$ARCH-$BUILD.txz )
+#( cd $PKG6
+#  makepkg -l y -c n $TMP/gcc-objc-$VERSION-$ARCH-$BUILD.txz )
+#( cd $PKG8
+#  makepkg -l y -c n $TMP/gcc-go-$VERSION-$ARCH-$BUILD.txz )
+#( cd $PKG9
+#  makepkg -l y -c n $TMP/gcc-brig-$VERSION-$ARCH-$BUILD.txz )
 
 echo
 echo "Slackware GCC package build complete!"
