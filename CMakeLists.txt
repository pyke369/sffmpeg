PROJECT(sffmpeg)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
INCLUDE(ExternalProject)
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_BINARY_DIR}/include)
LINK_DIRECTORIES(${CMAKE_BINARY_DIR}/lib)
SET(ENV{PATH} ${CMAKE_BINARY_DIR}/bin:$ENV{PATH})
SET(ENV{PKG_CONFIG_PATH} ${CMAKE_BINARY_DIR}/lib/pkgconfig)

EXTERNALPROJECT_ADD(
  yasm
  # URL http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/yasm-1.3.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh yasm
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  nasm
  # URL https://www.nasm.us/pub/nasm/releasebuilds/2.14/nasm-2.14.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/nasm-2.14.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh nasm
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  zlib
  # URL https://github.com/madler/zlib/archive/v1.2.11.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/zlib-v1.2.11.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh zlib
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  openssl
  # URL http://www.openssl.org/source/openssl-1.0.2q.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/openssl-1.0.2q.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh openssl
  CONFIGURE_COMMAND ./config no-shared no-idea no-mdc2 no-rc5 --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make depend && make
  INSTALL_COMMAND make install_sw
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  opencore-amr
  # URL http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/opencore-amr-0.1.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh opencore-amr
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fdkaac
  # URL http://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/fdk-aac-2.0.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fdkaac
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  lame
  # URL http://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/lame-3.100.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh lame
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libogg
  # URL http://downloads.xiph.org/releases/ogg/libogg-1.3.3.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libogg-1.3.3.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libogg
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  speex
  # URL http://downloads.xiph.org/releases/speex/speex-1.2.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/speex-1.2.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh speex
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-binaries --enable-sse
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libvorbis
  DEPENDS libogg
  # URL http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.6.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libvorbis-1.3.6.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libvorbis
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-oggtest
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libtheora
  DEPENDS libogg
  # URL http://downloads.xiph.org/releases/theora/libtheora-1.2.0alpha1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libtheora-1.2.0alpha1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libtheora
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-oggtest --disable-examples --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  opus
  # URL http://downloads.xiph.org/releases/opus/opus-1.3.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/opus-1.3.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh opus
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-doc
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  xvidcore
  DEPENDS yasm
  # URL http://downloads.xvid.org/downloads/xvidcore-1.3.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/xvidcore-1.3.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh xvidcore
  CONFIGURE_COMMAND cd build/generic && PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND cd build/generic && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build/generic && make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  x264
  DEPENDS nasm
  # GIT_REPOSITORY git://git.videolan.org/x264.git
  # UPDATE_COMMAND ""
  URL ${CMAKE_SOURCE_DIR}/vendor/x264-snapshot-20190129.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh x264
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --enable-static --enable-pic --enable-lto
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  x265
  DEPENDS nasm
  # URL https://bitbucket.org/multicoreware/x265/downloads/x265_3.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/x265_3.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh x265
  CONFIGURE_COMMAND cd build/linux && PATH=$ENV{PATH} cmake -G "Unix Makefiles" -D CMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR} -D ENABLE_CLI:BOOL=OFF -D ENABLE_SHARED:BOOL=OFF ../../source
  BUILD_COMMAND cd build/linux && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build/linux && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libvpx
  DEPENDS yasm
  # URL https://github.com/webmproject/libvpx/archive/master.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libvpx-snapshot-20190208.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libvpx
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --as=yasm --disable-docs --disable-examples --disable-shared --disable-tools --disable-unit-tests --enable-better-hw-compatibility --enable-multi-res-encoding  --enable-pic --enable-postproc --enable-runtime-cpu-detect --enable-vp9-temporal-denoising --enable-vp9-postproc --enable-webm-io --size-limit=16384x16384
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  aom
  DEPENDS yasm
  # DOWNLOAD_COMMAND git clone https://aomedia.googlesource.com/aom
  # UPDATE_COMMAND git pull
  URL ${CMAKE_SOURCE_DIR}/vendor/aom-snapshot-20190129.tar.bz2
  CONFIGURE_COMMAND PATH=$ENV{PATH} cmake -D BUILD_SHARED_LIBS=0 -D CMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR} -D ENABLE_DOCS:BOOL=OFF -D ENABLE_EXAMPLES:BOOL=OFF -D ENABLE_TESTS:BOOL=OFF -D ENABLE_TOOLS:BOOL=OFF -D INCLUDE_INSTALL_DIR:PATH=${CMAKE_BINARY_DIR}/include -D LIB_INSTALL_DIR:PATH=${CMAKE_BINARY_DIR}/lib ../aom
  BUILD_COMMAND PATH=$ENV{PATH} make
  INSTALL_COMMAND PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 0
)
EXTERNALPROJECT_ADD(
  rtmpdump
  DEPENDS zlib openssl
  # GIT_REPOSITORY git://git.ffmpeg.org/rtmpdump
  # UPDATE_COMMAND ""
  URL ${CMAKE_SOURCE_DIR}/vendor/rtmpdump-2.4.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh rtmpdump
  CONFIGURE_COMMAND ""
  BUILD_COMMAND make PREFIX=${CMAKE_BINARY_DIR} SHARED= XCFLAGS=-I${CMAKE_BINARY_DIR}/include XLDFLAGS=-L${CMAKE_BINARY_DIR}/lib XLIBS=-ldl
  INSTALL_COMMAND make PREFIX=${CMAKE_BINARY_DIR} SHARED= install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  freetype
  # URL http://download.savannah.gnu.org/releases/freetype/freetype-2.9.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/freetype-2.9.1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh freetype
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static --without-png
  INSTALL_COMMAND make install && ln -s ${CMAKE_BINARY_DIR}/include/freetype2 ${CMAKE_BINARY_DIR}/include/freetype2/freetype
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fribidi
  # URL http://fribidi.org/download/fribidi-1.0.5.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/fribidi-1.0.5.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fribidi
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  expat
  # URL http://downloads.sourceforge.net/project/expat/expat/2.2.5/expat-2.2.6.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/expat-2.2.6.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh expat
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fontconfig
  DEPENDS freetype expat
  # URL http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.6.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/fontconfig-2.12.6.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fontconfig
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libass
  DEPENDS yasm freetype fribidi fontconfig
  # URL https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libass-0.14.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libass
  CONFIGURE_COMMAND PATH=$ENV{PATH}:${CMAKE_BINARY_DIR}/bin PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libpciaccess
  # URL https://www.x.org/archive/individual/lib/libpciaccess-0.14.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/libpciaccess-0.14.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libpciaccess
  CONFIGURE_COMMAND PATH=$ENV{PATH}:${CMAKE_BINARY_DIR}/bin PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libdrm
  DEPENDS libpciaccess
  # URL https://dri.freedesktop.org/libdrm/libdrm-2.4.97.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/libdrm-2.4.97.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libdrm
  CONFIGURE_COMMAND PATH=$ENV{PATH}:${CMAKE_BINARY_DIR}/bin PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libva
  DEPENDS libdrm
  # URL https://github.com/intel/libva/releases/download/2.4.0/libva-2.4.0.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/libva-2.4.0.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libva
  CONFIGURE_COMMAND PATH=$ENV{PATH}:${CMAKE_BINARY_DIR}/bin PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static --enable-drm
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  intel-vaapi-driver
  DEPENDS libva
  # URL https://github.com/intel/intel-vaapi-driver/releases/download/2.3.0/intel-vaapi-driver-2.3.0.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/intel-vaapi-driver-2.3.0.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh intel-vaapi-driver
  CONFIGURE_COMMAND PATH=$ENV{PATH}:${CMAKE_BINARY_DIR}/bin PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  nv-codec-headers
  # URL https://github.com/FFmpeg/nv-codec-headers/releases/download/n8.2.15.6/nv-codec-headers-8.2.15.6.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/nv-codec-headers-8.2.15.6.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh nv-codec-headers
  CONFIGURE_COMMAND true
  INSTALL_COMMAND PATH=$ENV{PATH} make PREFIX=${CMAKE_BINARY_DIR} install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  ffmpeg
  DEPENDS yasm opencore-amr fdkaac lame libogg speex libvorbis libtheora opus xvidcore x264 x265 libvpx rtmpdump freetype libass openssl aom intel-vaapi-driver nv-codec-headers
  # URL https://ffmpeg.org/releases/ffmpeg-4.1.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-4.1.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh ffmpeg
  CONFIGURE_COMMAND PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --datadir=${CMAKE_BINARY_DIR}/etc --disable-shared --enable-static --enable-pic --pkg-config-flags=--static --enable-gpl --enable-version3 --enable-nonfree --disable-doc --disable-debug --disable-ffplay --disable-outdevs --enable-runtime-cpudetect --extra-cflags=-I${CMAKE_BINARY_DIR}/include\ -static --extra-ldflags=-L${CMAKE_BINARY_DIR}/lib --extra-libs=-lstdc++\ -lexpat\ -ldl\ -lm\ -lpthread --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libaom --enable-libfdk-aac --enable-libmp3lame --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx --enable-libopus --enable-librtmp --enable-libfreetype --enable-libass --enable-openssl --enable-vaapi
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libpng
  DEPENDS zlib
  # URL http://download.sourceforge.net/libpng/libpng-1.6.36.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libpng-1.6.36.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libpng
  CONFIGURE_COMMAND CFLAGS=-I${CMAKE_BINARY_DIR}/include CPPFLAGS=-I${CMAKE_BINARY_DIR}/include LDFLAGS=-L${CMAKE_BINARY_DIR}/lib ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  frmxtract
  DEPENDS ffmpeg libpng
  URL ${CMAKE_SOURCE_DIR}/vendor/frmxtract-3.3.3.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh frmxtract
  CONFIGURE_COMMAND CC=${CMAKE_C_COMPILER} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
