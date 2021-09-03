#!/bin/bash

R="$( cd "$( dirname "${BASH_SOURCE[0]-$0}" )" >/dev/null 2>&1 && pwd )"

# dev
export LIBRARY_PATH=${R}/install/lib:${LIBRARY_PATH}
export VPL_DIR=${R}/install/lib/cmake/vpl
export VA_ROOT_DIR=${R}/install
export MFX_HOME=${R}/install
# runtime
export LD_LIBRARY_PATH=${R}/install/lib:${LD_LIBRARY_PATH}
export LIBVA_DRIVER_NAME=iHD
export LIBVA_DRIVERS_PATH=${R}/install/lib/dri
export LIBVA_MESSAGING_LEVEL=0
