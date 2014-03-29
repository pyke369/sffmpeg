PROJECT(ffmpeg)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
INCLUDE(ExternalProject)
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_BINARY_DIR}/include)
LINK_DIRECTORIES(${CMAKE_BINARY_DIR}/lib)
SET(ENV{PATH} $ENV{PATH}:${CMAKE_BINARY_DIR}/bin)

EXTERNALPROJECT_ADD(
  yasm
  URL http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
  PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/vendor/yasm-performance.patch
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  z
  URL http://zlib.net/zlib-1.2.8.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  openssl
  URL http://www.openssl.org/source/openssl-1.0.1f.tar.gz
  CONFIGURE_COMMAND ./config no-shared no-idea no-mdc2 no-rc5 --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make depend && make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  opencore
  URL http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.3.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  faac
  URL http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --without-mp4v2
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  aacplus
  URL http://217.20.164.161/~tipok/aacplus/libaacplus-2.0.2.tar.gz
  PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/vendor/libaacplus-limit-nrg-range.patch
  CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fdkaac
  URL http://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-0.1.3.tar.gz
  PATCH_COMMAND sh ${CMAKE_SOURCE_DIR}/vendor/libaacplus-fdkaac-unclash.sh
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  mp3lame
  URL http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  ogg
  URL http://downloads.xiph.org/releases/ogg/libogg-1.3.1.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  speex
  DEPENDS ogg
  URL http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-sse  --disable-oggtest --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  vorbis
  DEPENDS ogg
  URL http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-oggtest
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  theora
  DEPENDS ogg
  URL http://downloads.xiph.org/releases/theora/libtheora-1.2.0alpha1.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-sse --disable-oggtest --disable-examples --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  xvidcore
  DEPENDS yasm
  URL http://downloads.xvid.org/downloads/xvidcore-1.3.2.tar.gz
  CONFIGURE_COMMAND cd build/generic && PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND cd build/generic && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build/generic && make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  x264
  DEPENDS yasm
  GIT_REPOSITORY git://git.videolan.org/x264.git
  UPDATE_COMMAND ""
  # PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/vendor/x264-watermark.patch
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  x265
  DEPENDS yasm
  DOWNLOAD_COMMAND hg clone https://bitbucket.org/multicoreware/x265
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND cd build/linux && PATH=$ENV{PATH} cmake -G "Unix Makefiles" -D CMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR} -D ENABLE_CLI:BOOL=OFF -D ENABLE_SHARED:BOOL=OFF ../../source
  BUILD_COMMAND cd build/linux && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build/linux && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  vpx
  DEPENDS yasm
  URL http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  rtmp
  DEPENDS z openssl
  GIT_REPOSITORY git://git.ffmpeg.org/rtmpdump
  UPDATE_COMMAND ""
  PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/vendor/rtmpdump-2.4-prefix.patch
  CONFIGURE_COMMAND ""
  BUILD_COMMAND make PREFIX=${CMAKE_BINARY_DIR} SHARED= XCFLAGS=-I${CMAKE_BINARY_DIR}/include XLDFLAGS=-L${CMAKE_BINARY_DIR}/lib XLIBS=-ldl
  INSTALL_COMMAND make PREFIX=${CMAKE_BINARY_DIR} SHARED= install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  freetype
  URL http://download.savannah.gnu.org/releases/freetype/freetype-2.5.2.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static --without-png
  INSTALL_COMMAND make install && ln -s ${CMAKE_BINARY_DIR}/include/freetype2 ${CMAKE_BINARY_DIR}/include/freetype2/freetype
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  ffmpeg
  DEPENDS yasm opencore faac aacplus fdkaac mp3lame ogg speex vorbis theora xvidcore x264 x265 vpx rtmp freetype
  URL http://www.ffmpeg.org/releases/ffmpeg-2.2.tar.bz2
  PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-libx265-apichange.patch
  CONFIGURE_COMMAND PATH=$ENV{PATH} PKG_CONFIG_PATH=${CMAKE_BINARY_DIR}/lib/pkgconfig ./configure --prefix=${CMAKE_BINARY_DIR} --datadir=${CMAKE_BINARY_DIR}/etc --disable-shared --enable-static --enable-gpl --enable-version3 --enable-nonfree --disable-doc --disable-debug --disable-ffplay --disable-ffserver --disable-avdevice --disable-outdevs --enable-runtime-cpudetect --enable-memalign-hack --extra-cflags=-I${CMAKE_BINARY_DIR}/include\ --static --extra-ldflags=-L${CMAKE_BINARY_DIR}/lib\ -static --extra-libs=-lstdc++\ -ldl --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libfaac --enable-libfdk-aac --enable-libaacplus --enable-libmp3lame --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx --enable-librtmp --enable-libfreetype
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
