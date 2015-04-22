#!/bin/bash

set -e

cd ${SRC_DIR}
tar xf download

cd TPP-${PKG_VERSION}
cd trans_proteomic_pipeline/src

echo "TPP_ROOT=${PREFIX}/" > Makefile.config.incl

if [ ${CPU_COUNT} -lt 20 ]
then
	PROC_COUNT=${CPU_COUNT}
else
	PROC_COUNT=20
fi

make -j ${PROC_COUNT}
make install
