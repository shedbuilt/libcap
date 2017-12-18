#!/bin/bash
# Suppress static library
sed -i '/install.*STALIBNAME/d' libcap/Makefile
# Address compilation issue when gperf-3.1+ is installed
patch -Np1 -i "$SHED_PATCHDIR/libcap-2.25-with-gperf-3.1.patch"
make -j $SHED_NUMJOBS || exit 1
make "DESTDIR=${SHED_FAKEROOT}" RAISE_SETFCAP=no lib=lib prefix=/usr install || exit 1
chmod -v 755 "${SHED_FAKEROOT}/usr/lib/libcap.so"
mkdir -v "${SHED_FAKEROOT}/lib"
mv -v ${SHED_FAKEROOT}/usr/lib/libcap.so.* "${SHED_FAKEROOT}/lib"
ln -sfv "../../lib/$(readlink ${SHED_FAKEROOT}/usr/lib/libcap.so)" "${SHED_FAKEROOT}/usr/lib/libcap.so"
