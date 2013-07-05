`sffmpeg` is a simple cmake-based full-featured FFmpeg static build helper.

It currently works on Linux, OpenBSD, FreeBSD, and MacOSX. It has been tested the most heavily on Linux/x86_64 (Ubuntu 12.04).
The helper will grab the latest versions of most FFmpeg dependencies, providing a way to effectively build, test and compare
multiple static builds of FFmpeg on the same host.

Requirements
------------

`sffmpeg` requires:

- a POSIX-compliant system (virtually any system today).
- recent versions of [gcc](http://gcc.gnu.org/) and [yasm](http://yasm.tortall.net/) (1.2+).
- a recent version of [cmake](http://www.cmake.org/) (2.8.2+).
- the [autoconf](http://www.gnu.org/software/autoconf/) and [libtool](http://www.gnu.org/software/libtool/) utilities.
- the [pkg-config](http://www.freedesktop.org/wiki/Software/pkg-config) utility.

Usage
-----

Just type the following commands at the shell prompt:

    $ git clone git@github.com:pyke369/sffmpeg
    $ cd sffmpeg
    $ make

Then go grab a coffee (or maybe two). The helper will download and compile all FFmpeg dependencies for you.
Once done, you should get a static system-independent FFmpeg binary in the `build/bin` directory.

    $ ./build/bin/ffmpeg
    ffmpeg version 1.2 Copyright (c) 2000-2013 the FFmpeg developers
      built on Jun  6 2013 12:48:53 with gcc 4.6 (Ubuntu/Linaro 4.6.3-1ubuntu5)
      libavutil      52. 18.100 / 52. 18.100
      libavcodec     54. 92.100 / 54. 92.100
      libavformat    54. 63.104 / 54. 63.104
      libavfilter     3. 42.103 /  3. 42.103
      libswscale      2.  2.100 /  2.  2.100
      libswresample   0. 17.102 /  0. 17.102
      libpostproc    52.  2.100 / 52.  2.100
    Hyper fast Audio and Video encoder
    usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

    $ ldd ./build/bin/ffmpeg
    ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked

From there, you may use the binary immediately or build a Debian package for later deployment (see below).

Packaging
---------

You may optionally build a Debian package by typing the following command at the shell prompt:

    $ make deb

All binaries and support files will be installed by the package in the `/usr/local` directory.

    $ sudo dpkg -i sffmpeg_1.2_amd64.deb
    Selecting previously deselected package sffmpeg.
    Unpacking sffmpeg (from sffmpeg_1.2_amd64.deb) ...
    Setting up sffmpeg (1.2) ...
