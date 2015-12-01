#!/bin/sh

PATCHES_ROOT=`dirname $0`/ffmpeg-patches
for PATCH in `ls ${PATCHES_ROOT}`
do
    patch -p 1 < ${PATCHES_ROOT}/${PATCH}
done
