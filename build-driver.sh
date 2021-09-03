#!/bin/bash

set -ex

SRC=$(readlink -f $1)
DST=$(readlink -f $2)

export PATH=/usr/lib/ccache:$PATH
cd $SRC

TAG_LIBVA=2.12.0
TAG_LIBVA_UTILS=2.12.0
TAG_GMMLIB=intel-gmmlib-21.2.1
TAG_MEDIA_DRIVER=intel-media-21.2.3
TAG_ONEVPL=v2021.5.0
TAG_ONEVPL_GPU=intel-onevpl-21.3.3
#TAG_ONEVPL_CPU=v2021.5.0
TAG_MEDIASDK=intel-mediasdk-21.2.3

# ===== LIBVA

[ ! -d libva ] && git clone --depth=1 https://github.com/intel/libva --branch ${TAG_LIBVA}
pushd libva
./autogen.sh --prefix=${DST}
make -j8
make install
popd

export PKG_CONFIG_PATH=${DST}/lib/pkgconfig

# ===== LIBVA-utils

[ ! -d libva-utils ] && git clone --depth=1 https://github.com/intel/libva-utils --branch ${TAG_LIBVA_UTILS}
pushd libva-utils
./autogen.sh --prefix=${DST}
make -j8
make install
popd

# ===== GMMLIB

[ ! -d gmmlib ] && git clone --depth=1 https://github.com/intel/gmmlib.git --branch ${TAG_GMMLIB}
mkdir -p gmmlib/build
pushd gmmlib/build
rm -rf *
cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} -DRUN_TEST_SUITE=OFF ..
ninja install
popd

# ===== iHD

[ ! -d media-driver ] && git clone --depth=1 https://github.com/intel/media-driver.git --branch ${TAG_MEDIA_DRIVER}
mkdir -p media-driver/build
pushd media-driver/build
rm -rf *
cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} -DMEDIA_RUN_TEST_SUITE=OFF ..
ninja install
popd

# ===== oneVPL

export LIBRARY_PATH=${DST}/lib

[ ! -d oneVPL ] && git clone --depth=1 https://github.com/oneapi-src/oneVPL.git --branch ${TAG_ONEVPL}
mkdir -p oneVPL/build
pushd oneVPL/build
rm -rf * && cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} .. && ninja install
popd


# ===== oneVPL-GPU
[ ! -d oneVPL-intel-gpu ] && git clone --depth=1 https://github.com/oneapi-src/oneVPL-intel-gpu.git --branch ${TAG_ONEVPL_GPU}
export MFX_HOME=$(readlink -f oneVPL-intel-gpu)
mkdir -p oneVPL-intel-gpu/build
pushd oneVPL-intel-gpu/build
rm -rf *
cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} ..
ninja install
popd

# ===== oneVPL-CPU
#[ ! -d oneVPL-cpu ] && git clone --depth=1 https://github.com/oneapi-src/oneVPL-cpu.git --branch ${TAG_ONEVPL_CPU}
#mkdir -p oneVPL-cpu/build
#pushd oneVPL-cpu/build
#rm -rf *
#cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} ..
#ninja install
#popd


# ===== MediaSDK
[ ! -d MediaSDK ] && git clone --depth=1 https://github.com/Intel-Media-SDK/MediaSDK.git --branch ${TAG_MEDIASDK}
mkdir -p MediaSDK/build
pushd MediaSDK/build
rm -rf *
cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} ..
ninja install
popd
