#!/bin/bash
# Suppress static library
sed -i '/install.*STALIBNAME/d' libcap/Makefile
# Address compilation issue when gperf-3.1+ is installed
patch -Np1 -i "$SHED_PKG_PATCH_DIR/libcap-2.25-with-gperf-3.1.patch"
make -j $SHED_NUM_JOBS || exit 1
make "DESTDIR=${SHED_FAKE_ROOT}" RAISE_SETFCAP=no lib=lib prefix=/usr install || exit 1
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libcap.so"
mkdir -v "${SHED_FAKE_ROOT}/lib"
mv -v ${SHED_FAKE_ROOT}/usr/lib/libcap.so.* "${SHED_FAKE_ROOT}/lib"
ln -sfv "../../lib/$(readlink ${SHED_FAKE_ROOT}/usr/lib/libcap.so)" "${SHED_FAKE_ROOT}/usr/lib/libcap.so"
