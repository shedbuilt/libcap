#!/bin/bash
sed -i '/install.*STALIBNAME/d' libcap/Makefile
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} RAISE_SETFCAP=no lib=lib prefix=/usr install
chmod -v 755 ${SHED_FAKEROOT}/usr/lib/libcap.so
mkdir -v ${SHED_FAKEROOT}/lib
mv -v ${SHED_FAKEROOT}/usr/lib/libcap.so.* ${SHED_FAKEROOT}/lib
ln -sfv ../../lib/$(readlink ${SHED_FAKEROOT}/usr/lib/libcap.so) ${SHED_FAKEROOT}/usr/lib/libcap.so
