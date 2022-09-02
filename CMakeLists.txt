PROJECT(sffmpeg)

CMAKE_MINIMUM_REQUIRED(VERSION 3.6)
INCLUDE(ExternalProject)
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_BINARY_DIR}/include)
LINK_DIRECTORIES(${CMAKE_BINARY_DIR}/lib)
SET(ENV{PATH} ${CMAKE_BINARY_DIR}/bin:$ENV{PATH})
SET(ENV{PKG_CONFIG_PATH} ${CMAKE_BINARY_DIR}/lib/pkgconfig)

EXTERNALPROJECT_ADD(
  openssl
  # URL https://www.openssl.org/source/openssl-1.1.1q.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/openssl-1.1.1q.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh openssl
  CONFIGURE_COMMAND ./config no-shared no-idea no-mdc2 no-rc5 --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make depend && make -j${CONCURRENCY}
  INSTALL_COMMAND make install_sw
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  opencore-amr
  # URL https://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.6.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/opencore-amr-0.1.6.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh opencore-amr
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fdkaac
  # URL https://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.2.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/fdk-aac-2.0.2.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fdkaac
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  lame
  # URL https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/lame-3.100.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh lame
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libogg
  # URL https://downloads.xiph.org/releases/ogg/libogg-1.3.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libogg-1.3.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libogg
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  speex
  DEPENDS libogg
  # URL https://downloads.xiph.org/releases/speex/speex-1.2.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/speex-1.2.1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh speex
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-sse  --disable-oggtest --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libvorbis
  DEPENDS libogg
  # URL https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libvorbis-1.3.7.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libvorbis
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-oggtest --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libtheora
  DEPENDS libogg
  # URL https://downloads.xiph.org/releases/theora/libtheora-1.2.0alpha1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libtheora-1.2.0alpha1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libtheora
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-oggtest --disable-examples --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  opus
  # URL https://downloads.xiph.org/releases/opus/opus-1.3.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/opus-1.3.1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh opus
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-doc
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  nasm
  # URL https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/nasm-2.15.05.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh nasm
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  xvidcore
  DEPENDS nasm
  # URL https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/xvidcore-1.3.7.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh xvidcore
  CONFIGURE_COMMAND cd build/generic && PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND cd build/generic && PATH=$ENV{PATH} make -j${CONCURRENCY}
  INSTALL_COMMAND cd build/generic && make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  x264
  DEPENDS nasm
  # GIT_REPOSITORY git://code.videolan.org/videolan/x264
  URL ${CMAKE_SOURCE_DIR}/vendor/x264-20220602-0131-stable.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh x264
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  x265
  DEPENDS nasm
  # URL https://bitbucket.org/multicoreware/x265_git/downloads/x265_3.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/x265_3.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh x265
  CONFIGURE_COMMAND cd build/linux && PATH=$ENV{PATH} cmake -G "Unix Makefiles" -D CMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR} -D ENABLE_CLI:BOOL=OFF -D ENABLE_SHARED:BOOL=OFF ../../source
  BUILD_COMMAND cd build/linux && PATH=$ENV{PATH} make -j${CONCURRENCY}
  INSTALL_COMMAND cd build/linux && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  aom
  DEPENDS nasm
  # GIT_REPOSITORY git://aomedia.googlesource.com/aom.git
  URL ${CMAKE_SOURCE_DIR}/vendor/aom-v3.3.0.tgz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh aom
  CONFIGURE_COMMAND cd build && PATH=$ENV{PATH} cmake .. -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}
  BUILD_COMMAND cd build && PATH=$ENV{PATH} make -j${CONCURRENCY}
  INSTALL_COMMAND cd build && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libvpx
  DEPENDS nasm
  # URL https://github.com/webmproject/libvpx/archive/refs/tags/v1.12.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libvpx-1.12.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libvpx
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND PATH=$ENV{PATH} make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  srt
  DEPENDS openssl
  # URL https://github.com/Haivision/srt/archive/refs/tags/v1.5.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/srt-v1.5.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh srt
  CONFIGURE_COMMAND mkdir -p build && cd build && PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} cmake -DENABLE_SHARED=0 -DENABLE_APPS=0 -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR} ..
  BUILD_COMMAND cd build && PATH=$ENV{PATH} make -j${CONCURRENCY}
  INSTALL_COMMAND cd build && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  zlib
  # URL https://github.com/madler/zlib/archive/refs/tags/v1.2.12.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/zlib-v1.2.12.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh zlib
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libpng
  DEPENDS zlib
  # URL https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libpng-1.6.37.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libpng
  CONFIGURE_COMMAND CFLAGS=-I${CMAKE_BINARY_DIR}/include CPPFLAGS=-I${CMAKE_BINARY_DIR}/include LDFLAGS=-L${CMAKE_BINARY_DIR}/lib ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  freetype
  DEPENDS libpng zlib
  # URL https://download.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/freetype-2.12.1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh freetype
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static --with-zlib
  BUILD_COMMAND make -j${CONCURRENCY}
  INSTALL_COMMAND make install && ln -s ${CMAKE_BINARY_DIR}/include/freetype2 ${CMAKE_BINARY_DIR}/include/freetype2/freetype
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fribidi
  # URL https://github.com/fribidi/fribidi/releases/download/v1.0.12/fribidi-1.0.12.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/fribidi-1.0.12.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fribidi
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  expat
  # URL https://github.com/libexpat/libexpat/releases/download/R_2_4_8/expat-2.4.8.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/expat-2.4.8.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh expat
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  gperf
  # URL http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/gperf-3.1.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  fontconfig
  DEPENDS freetype expat gperf
  # URL https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.14.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/fontconfig-2.14.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fontconfig
  CONFIGURE_COMMAND PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  harfbuzz
  DEPENDS fontconfig
  # URL https://github.com/harfbuzz/harfbuzz/releases/download/5.1.0/harfbuzz-5.1.0.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/harfbuzz-5.1.0.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh harfbuzz
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libass
  DEPENDS nasm fribidi harfbuzz
  # URL https://github.com/libass/libass/releases/download/0.16.0/libass-0.16.0.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/libass-0.16.0.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libass
  CONFIGURE_COMMAND PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libtool
  # URL https://ftpmirror.gnu.org/libtool/libtool-2.4.7.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libtool-2.4.7.tar.gz
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  zimg
  DEPENDS nasm libtool
  # URL https://github.com/sekrit-twc/zimg/archive/refs/tags/release-3.0.4.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/zimg-3.0.4.tar.gz
  CONFIGURE_COMMAND PATH=$ENV{PATH} ACLOCAL_PATH=${CMAKE_BINARY_DIR}/share/aclocal ./autogen.sh && ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  xorg-macros
  # URL https://github.com/freedesktop/xorg-macros/archive/refs/tags/util-macros-1.19.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/xorg-macros-1.19.1.tar.gz
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./autogen.sh && ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libpciaccess
  DEPENDS xorg-macros libtool
  # URL https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/libpciaccess-0.16/libpciaccess-libpciaccess-0.16.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libpciaccess-0.16.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libpciaccess
  CONFIGURE_COMMAND PATH=$ENV{PATH} ACLOCAL_PATH=${CMAKE_BINARY_DIR}/share/aclocal ./autogen.sh && CFLAGS=-fPIC ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libdrm
  DEPENDS libpciaccess
  # URL https://dri.freedesktop.org/libdrm/libdrm-2.4.100.tar.bz2
  # URL https://dri.freedesktop.org/libdrm/libdrm-2.4.113.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/libdrm-2.4.100.tar.bz2
  # URL ${CMAKE_SOURCE_DIR}/vendor/libdrm-2.4.113.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libdrm
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} CFLAGS=-fPIC ./configure --prefix=${CMAKE_BINARY_DIR} --disable-vmwgfx --disable-radeon --disable-amdgpu --disable-nouveau --disable-shared
  # CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} meson --prefix=${CMAKE_BINARY_DIR} --libdir=lib build -Dvmwgfx=false -Dradeon=false -Damdgpu=false -Dnouveau=false -Dvalgrind=false -Dman-pages=false
  BUILD_COMMAND make -j${CONCURRENCY}
  # BUILD_COMMAND ninja -C build
  # INSTALL_COMMAND ninja -C build install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libva
  DEPENDS libdrm
  # URL https://github.com/intel/libva/releases/download/2.15.0/libva-2.15.0.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/intel-libva-2.15.0.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libva
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} CFLAGS=-fPIC ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --with-drivers-path=/usr/local/lib/dri
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  gmmlib
  # URL https://github.com/intel/gmmlib/archive/refs/tags/intel-gmmlib-22.1.7.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/intel-gmmlib-22.1.7.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh gmmlib
  CONFIGURE_COMMAND mkdir -p build && cd build && PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} cmake -DCMAKE_INSTALL_INCLUDEDIR=${CMAKE_BINARY_DIR}/include -DCMAKE_INSTALL_LIBDIR=${CMAKE_BINARY_DIR}/lib ..
  BUILD_COMMAND cd build && make -j${CONCURRENCY}
  INSTALL_COMMAND cd build && make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  intel-media-driver
  DEPENDS libva gmmlib
  # URL https://github.com/intel/media-driver/archive/refs/tags/intel-media-22.4.4.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/intel-media-driver-22.4.4.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh intel-media-driver
  CONFIGURE_COMMAND mkdir -p build && cd build && PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} cmake -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR} -DLIBVA_DRIVERS_PATH=${CMAKE_BINARY_DIR}/lib/dri -DMEDIA_RUN_TEST_SUITE=0 ..
  BUILD_COMMAND cd build && make -j${CONCURRENCY}
  INSTALL_COMMAND cd build && make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  intel-media-sdk
  DEPENDS intel-media-driver
  # URL https://github.com/Intel-Media-SDK/MediaSDK/archive/refs/tags/intel-mediasdk-22.4.4.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/intel-media-sdk-22.4.4.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh intel-media-sdk
  CONFIGURE_COMMAND mkdir -p build && cd build && PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} cmake -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR} -DMFX_MODULES_DIR=/usr/local/lib -DMFX_PLUGINS_CONF_DIR=/usr/local/lib/mfx -DMFX_PLUGINS_DIR=/usr/local/lib/mfx -DMFX_APPS_DIR=${CMAKE_BINARY_DIR} -DBUILD_TUTORIALS=OFF ..
  BUILD_COMMAND cd build && make -j${CONCURRENCY}
  INSTALL_COMMAND cd build && make install
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  gputop
  DEPENDS intel-media-sdk
  URL ${CMAKE_SOURCE_DIR}/vendor/gputop-22.4.4.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh gputop
  CONFIGURE_COMMAND CFLAGS=-I${CMAKE_BINARY_DIR}/samples LDFLAGS=-L${CMAKE_BINARY_DIR}/samples ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  libxcoder
  URL ${CMAKE_SOURCE_DIR}/vendor/libxcoder-3.1.10-rc7.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libxcoder
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  ffmpeg
  DEPENDS nasm zlib openssl opencore-amr fdkaac lame libogg opus speex libvorbis libtheora xvidcore x264 x265 aom libvpx srt freetype libass zimg intel-media-sdk libxcoder
  # URL https://ffmpeg.org/releases/ffmpeg-5.1.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-5.1.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh ffmpeg
  CONFIGURE_COMMAND PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --datadir=${CMAKE_BINARY_DIR}/etc --disable-shared --enable-static --enable-gpl --enable-version3 --enable-nonfree --enable-runtime-cpudetect --disable-doc --disable-debug --disable-ffplay --disable-indevs --disable-outdevs --extra-cflags=-I${CMAKE_BINARY_DIR}/include\ --static --extra-ldflags=-L${CMAKE_BINARY_DIR}/lib --extra-libs=-lvorbis\ -logg\ -lcrypto\ -lexpat\ -lharfbuzz\ -lfribidi\ -lz\ -ldrm\ -lpthread\ -lstdc++\ -lm\ -ldl --enable-openssl --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libxvid --enable-libx264 --enable-libx265 --enable-libaom --enable-libvpx --enable-libsrt --enable-libfontconfig --enable-libfreetype --enable-libass --enable-libzimg --enable-vaapi --enable-libmfx
  BUILD_COMMAND PATH=$ENV{PATH} make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
EXTERNALPROJECT_ADD(
  frmxtract
  DEPENDS ffmpeg libpng
  URL ${CMAKE_SOURCE_DIR}/vendor/frmxtract-5.1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh frmxtract
  CONFIGURE_COMMAND A=E CC=${CMAKE_C_COMPILER} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} EXTRA_LIBS=libdrm ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make -j${CONCURRENCY}
  BUILD_IN_SOURCE 1
)
