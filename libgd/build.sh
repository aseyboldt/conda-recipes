#!/bin/bash

set -e

cd ${SRC_DIR}

if [ ${CPU_COUNT} -lt 20 ]
then
	PROC_COUNT=${CPU_COUNT}
else
	PROC_COUNT=20
fi

./bootstrap.sh
./configure --prefix=${PREFIX}
make -j ${PROC_COUNT}
make install
