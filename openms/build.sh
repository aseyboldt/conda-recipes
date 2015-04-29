#!/bin/bash

set -e

echo "cloning contrib"

mkdir contrib
git clone https://github.com/OpenMS/contrib
cd contrib
git checkout f6b44d770b6c1b23972a8891753472e60a356253

#cmake . -DBUILD_TYPE=BOOST
cmake . -DBUILD_TYPE=SEQAN
cmake . -DBUILD_TYPE=WILDMAGIC
cmake . -DBUILD_TYPE=EIGEN
cmake . -DBUILD_TYPE=LIBSVM

echo "Build of contrib is complete"

cd ${SRC_DIR}

cmake . -DCMAKE_PREFIX_PATH=../contrib -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} -DBOOST_USE_STATIC=OFF -DHAS_XSERVER=off

if [ ${CPU_COUNT} -lt 20 ]
then
	PROC_COUNT=${CPU_COUNT}
else
	PROC_COUNT=20
fi

make -j ${PROC_COUNT} OpenMS
make -j ${PROC_COUNT} TOPP
make install

