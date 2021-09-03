#!/bin/bash

set -ex

SRC=$(readlink -f $1)
DST=$(readlink -f $2)

export PATH=/usr/lib/ccache:$PATH
cd $SRC

TAG_OPENCV=master

[ ! -d opencv ] && git clone --depth=1 https://github.com/opencv/opencv --branch ${TAG_OPENCV}
mkdir -p opencv/build
pushd opencv/build
cmake -GNinja -DCMAKE_INSTALL_PREFIX=${DST} -DINSTALL_TESTS=ON -DWITH_MFX=ON ..
ninja install
popd
