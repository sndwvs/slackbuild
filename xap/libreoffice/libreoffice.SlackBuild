#!/bin/bash

CWD=$(pwd)

NAME="libreoffice"
VERSION=6.4.5.2
BUILD=${BUILD:-1}
PACKAGER=${PACKAGER:-mara}

NUMJOBS=${NUMJOBS:-" -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null) "}

SOURCE_URL="https://downloadarchive.documentfoundation.org/libreoffice/old/${VERSION}/src"
SOURCE_URL2="https://dev-www.libreoffice.org/src"
SOURCE_URL3="https://dev-www.libreoffice.org/extern"

DOWNLOADS+=( ${SOURCE_URL}/libreoffice{,-help,-translations,-dictionaries}-${VERSION}.tar.xz{,.asc} )
DOWNLOADS+=( ${SOURCE_URL2}/35c94d2df8893241173de1d16b6034c0-swingExSrc.zip )
DOWNLOADS+=( ${SOURCE_URL2}/798b2ffdc8bcfe7bca2cf92b62caf685-rhino1_5R5.zip )
DOWNLOADS+=( ${SOURCE_URL2}/a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip )
DOWNLOADS+=( ${SOURCE_URL2}/0168229624cfac409e766913506961a8-ucpp-1.3.2.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/libabw-0.1.3.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libcdr-0.1.5.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libcmis-0.5.2.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/cppunit-1.14.0.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/libe-book-0.1.3.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libepubgen-0.1.1.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libetonyek-0.1.9.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libfreehand-0.1.2.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/bae83fa5dc7f081768daace6e199adc3-glm-0.9.4.6-libreoffice.zip )
DOWNLOADS+=( ${SOURCE_URL2}/5ade6ae2a99bc1e9e57031ca88d36dad-hyphen-2.8.8.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/libexttextcat-3.4.5.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/language-subtag-registry-2019-09-16.tar.bz2 )
DOWNLOADS+=( ${SOURCE_URL2}/liblangtag-0.6.2.tar.bz2 )
DOWNLOADS+=( ${SOURCE_URL2}/libnumbertext-1.0.5.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/xmlsec1-1.2.28.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/26b3e95ddf3d9c077c480ea45874b3b8-lp_solve_5.5.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/lxml-4.1.1.tgz )
DOWNLOADS+=( ${SOURCE_URL2}/QR-Code-generator-1.4.0.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/mdds-1.5.0.tar.bz2 )
DOWNLOADS+=( ${SOURCE_URL2}/libmspub-0.1.4.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libmwaw-0.3.15.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/a8c2c5b8f09e7ede322d5c602ff6a4b6-mythes-1.2.4.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/liborcus-0.15.3.tar.gz )
DOWNLOADS+=( ${SOURCE_URL2}/libpagemaker-0.0.4.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libqxp-0.0.2.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libstaroffice-0.0.6.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libwps-0.4.10.tar.xz )
DOWNLOADS+=( ${SOURCE_URL2}/libzmf-0.0.2.tar.xz )
DOWNLOADS+=( ${SOURCE_URL3}/8249374c274932a21846fa7629c2aa9b-officeotron-0.7.4-master.jar ) # for test suite
DOWNLOADS+=( ${SOURCE_URL3}/odfvalidator-1.2.0-incubating-SNAPSHOT-jar-with-dependencies-971c54fd38a968f5860014b44301872706f9e540.jar ) # for test suite
DOWNLOADS+=( ${SOURCE_URL3}/185d60944ea767075d27247c3162b3bc-unowinreg.dll )
DOWNLOADS+=( ${SOURCE_URL3}/884ed41809687c3e168fc7c19b16585149ff058eca79acbf3ee784f6630704cc-opens___.ttf )


# Automatically determine the architecture we're building on:
MARCH=$( uname -m )
if [ -z "$ARCH" ]; then
  case "$MARCH" in
    i?86)    export ARCH=i586 ;;
    armv7hl) export ARCH=$MARCH ;;
    arm*)    export ARCH=arm ;;
    # Unless $ARCH is already set, use uname -m for all other archs:
    *)       export ARCH=$MARCH ;;
  esac
fi

if [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O3 -march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O3 -fPIC"
  LIBDIRSUFFIX="64"
elif [ "$ARCH" = "armv7hl" ]; then
  SLKCFLAGS="-O3 -march=armv7-a -mfpu=vfpv3-d16"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "arm" ]; then
  SLKCFLAGS="-O3 -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "aarch64" ]; then
  SLKCFLAGS="-O3"
  LIBDIRSUFFIX="64"
else
  SLKCFLAGS="-O2"
  LIBDIRSUFFIX=""
fi

case "$ARCH" in
    arm*) TARGET=$ARCH-slackware-linux-gnueabihf ;;
    *)    TARGET=$ARCH-slackware-linux ;;
esac

# download sources
[[ ! -d $CWD/sources ]] && mkdir -p $CWD/sources
for dwnlds in ${DOWNLOADS[*]}; do
    OUT=${dwnlds##*/}
    wget --no-check-certificate -c "$dwnlds" -O "sources/$OUT"
done

# Establishment tmp directory for
TMP=${TMP:-/tmp}
PKG=$TMP/package-$NAME
rm -rf $PKG
mkdir -p $PKG

# Delete a directory previous build / create new and change rights
cd $TMP
rm -rf $NAME || exit 1
mkdir $NAME || exit 1
cd $NAME || exit 1
tar xvf $CWD/sources/$NAME-${VERSION}.tar.?z || exit 1
cd $NAME-${VERSION} || exit 1
chown -R root:root .
find . \
 \( -perm 777 -o -perm 775 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;

# move external sources into place
mkdir $TMP/$NAME/ext_sources && pushd $TMP/$NAME/ext_sources || exit 1
for _source in ${DOWNLOADS[*]}; do
    src=${_source##*/}
    ln -s $CWD/sources/$src .
done
popd

# unowinreg.dll must be a file not a symlink or the result will become a broken symlink
# /usr/share/libreoffice/sdk/classes/win/unowinreg.dll -> /build/libreoffice/src/185d60944ea767075d27247c3162b3bc-unowinreg.dll
rm $TMP/$NAME/ext_sources/185d60944ea767075d27247c3162b3bc-unowinreg.dll
cp -f $CWD/sources/185d60944ea767075d27247c3162b3bc-unowinreg.dll $TMP/$NAME/ext_sources

# remove check-if-root
patch -Np0 -i $CWD/makefile.in.patch || exit 1

# determine configure options based on installed packages on the system
[[ -e /usr/lib${LIBDIRSUFFIX}/ccache ]] && OPT_LIBREOFFICE+="" || OPT_LIBREOFFICE+=" --disable-ccache"
[[ -e /usr/lib${LIBDIRSUFFIX}/cups ]] && OPT_LIBREOFFICE+=" --enable-cups" || OPT_LIBREOFFICE+=" --disable-cups"
[[ -e /usr/lib${LIBDIRSUFFIX}/pkgconfig/gstreamer-plugins-base-1.0.pc ]] && OPT_LIBREOFFICE+=" --enable-gstreamer-1-0" || OPT_LIBREOFFICE+=" --disable-gstreamer-1-0"
[[ -e /usr/lib${LIBDIRSUFFIX}/pkgconfig/Qt5Core.pc ]] && OPT_LIBREOFFICE+=" --enable-qt5" || OPT_LIBREOFFICE+=" --disable-qt5"
[[ -e /usr/share/kf5/ ]] && OPT_LIBREOFFICE+=" --enable-kde5 --enable-gtk3-kde5"
[[ -e /usr/share/vlc ]] && OPT_LIBREOFFICE+=" --enable-vlc" || OPT_LIBREOFFICE+=" --disable-vlc" # experimental vlc av backend
[[ -e /usr/lib${LIBDIRSUFFIX}/pkgconfig/valgrind.pc ]] && OPT_LIBREOFFICE+=" --with-valgrind"

# http://site.icu-project.org/download/61#TOC-Migration-Issues
CPPFLAGS+=' -DU_USING_ICU_NAMESPACE=1'

# Configuration
./autogen.sh \
  $OPT_LIBREOFFICE \
  --with-parallelism=${NUMJOBS/-j/} \
  --prefix=/usr \
  --sysconfdir=/etc \
  --libdir=/usr/lib${LIBDIRSUFFIX} \
  --mandir=/usr/man \
  --docdir=/usr/doc/$NAME-$VERSION \
  --with-external-tar="$TMP/$NAME/ext_sources" \
  --enable-{build-opensymbol,dbus,firebird-sdbc=no,gtk3,introspection=yes,release-build,odk,openssl,python=system} \
  --with-{lang="",myspell-dicts,parallelism} \
  --with-build-version="${VERSION}-${BUILD}" \
  --with-extra-buildid="$(date +%Y%m%d)" \
  --with-vendor="Slarm64 Linux" \
  --with-package-version="${VERSION}" \
  --with-system-{headers,libs} \
  --with-external-dict-dir=/usr/share/hunspell \
  --with-external-hyph-dir=/usr/share/hypen \
  --with-external-thes-dir=/usr/share/mythes \
  --without-{doxygen,fonts,gssapi,help,helppack-integration,java,system-firebird} \
  --disable-{avahi,build-unowinreg,dconf,dependency-tracking,extension-update} \
  --disable-{firebird-sdbc,postgresql-sdbc,report-builder,sdremote-bluetooth,werror} \
  --disable-{coinmp,pdfium} \
  --without-system-{libcmis,xmlsec,libepubgen,libwps,libcdr,libmspub,libmwaw,libetonyek,libfreehand} \
  --without-system-{libebook,libabw,libpagemaker,libqxp,libzmf,libstaroffice,cppunit,mdds,glm,orcus} \
  --without-system-{altlinuxhyph,mythes,lpsolve,libexttextcat,libnumbertext,liblangtag,qrcodegen} \
  --build=$TARGET \
  --host=$TARGET

#  --disable-{avahi,build-unowinreg,dconf,dependency-tracking,extension-update,fetch-external} \
#  --with-{lang="",package-format=archive,myspell-dicts,parallelism} \

# Compilation
touch {sources.ver,src.downloaded}
echo "lo_sources_ver=${VERSION}" > sources.ver
make build-nocheck || exit 1

#pushd workdir/installation/LibreOffice/archive/install/en-US
#tar xf *.tar.gz
#popd

make DESTDIR=$PKG distro-pack-install


install -dm755 $PKG/etc/libreoffice
install -m644 $PKG/usr/lib${LIBDIRSUFFIX}/libreoffice/program/{bootstraprc,sofficerc} \
  $PKG/etc/libreoffice/
install -m644 $PKG/usr/lib${LIBDIRSUFFIX}/libreoffice/share/psprint/psprint.conf \
  $PKG/etc/libreoffice/

# install dummy links to make them found by lo
cd $PKG/usr/lib${LIBDIRSUFFIX}/libreoffice/program/
ln -vsrf $PKG/etc/libreoffice/{bootstraprc,sofficerc} .

# cleanup
rm -r $PKG/usr/share/libreoffice/sdk
rm -r $PKG/usr/lib${LIBDIRSUFFIX}/libreoffice/sdk
rm -r $PKG/usr/share/doc
find $PKG -iname "*readme*" -exec rm -fr '{}' \+


# Don't ship .la files:
rm -f $PKG/{,usr/}lib${LIBDIRSUFFIX}/*.la

# Strip binaries:
find $PKG | xargs file | grep -e "executable" -e "shared object" \
  | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null


# Compress manual pages:
find $PKG/usr/man -type f -exec gzip -9 {} \;
for i in $( find $PKG/usr/man -type l ) ; do
  ln -s $( readlink $i ).gz $i.gz
  rm $i
done

# Copy docs
mkdir -vpm755 $PKG/usr/doc/$NAME-$VERSION
cp -fav \
  LICENSE README \
  $PKG/usr/doc/$NAME-$VERSION/

# Description and installation script
mkdir -p $PKG/install
zcat $CWD/doinst.sh.gz > $PKG/install/doinst.sh
cat $CWD/slack-desc > $PKG/install/slack-desc

# Package creation
cd $PKG
makepkg -l n -c n $TMP/${NAME}-${VERSION}-${ARCH}-${BUILD}${PACKAGER}.txz
