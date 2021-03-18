#!/bin/sh

ROOT=`dirname $0`
PKG=$1
if [ -d ${ROOT}/${PKG} ]
then
    for RUN in `ls ${ROOT}/${PKG}/*.run 2>/dev/null`
    do
        ${RUN}
    done
    for PATCH in `ls ${ROOT}/${PKG}/*.patch 2>/dev/null`
    do
        patch -p 1 < ${PATCH}
    done
fi
