`sffmpeg` is a simple cmake-based full-featured FFmpeg static build helper.

It currently works on Linux, OpenBSD, FreeBSD, and MacOSX. It has been tested the most heavily on Linux/x86_64 (Ubuntu 11.04).
The helper will grab the latest versions of most FFmpeg dependencies, providing a way to effectively build, test and compare
multiple static builds of FFmpeg on the same host.

Requirements
------------

`sffmpeg` requires:

- a POSIX-compliant system (virtually any system today).
- a working C compiler (preferably [gcc](http://gcc.gnu.org/)) and assembler (preferably [yasm](http://yasm.tortall.net/)).
- a recent [cmake](http://www.cmake.org/) version (2.8+).
- the [pkg-config](http://www.freedesktop.org/wiki/Software/pkg-config) utility.

Usage
-----

Just type the following commands at the shell prompt:

    $ git clone git@github.com/pyke369/sffmpeg
    $ cd sffmpeg
    $ make

Then go grab a coffee (or maybe two). The helper will download and compile all FFmpeg dependencies for you.
Once done, you should get a static system-independent FFmpeg binary in the `build/bin` directory.

    $ ./build/bin/ffmpeg
    ffmpeg version N-31627-g9c2651a, Copyright (c) 2000-2011 the FFmpeg developers
      built on Jul 23 2011 19:37:59 with gcc 4.5.2
      libavutil    51. 11. 0 / 51. 11. 0
      libavcodec   53.  9. 0 / 53.  9. 0
      libavformat  53.  6. 0 / 53.  6. 0
      libavfilter   2. 27. 3 /  2. 27. 3
      libswscale    2.  0. 0 /  2.  0. 0
      libpostproc  51.  2. 0 / 51.  2. 0
    Hyper fast Audio and Video encoder
    usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

    $ ldd ./build/bin/ffmpeg 
    not a dynamic executable

From there, you may use the binary immediately or build a Debian package for later deployment (see below).

Packaging
---------

You may optionally build a Debian package by typing the following command at the shell prompt:

    $ make deb

All binaries and support files will be installed by the package in the `/usr/local` directory.

    $ sudo dpkg -i sffmpeg_1.0.0_amd64.deb 
    Selecting previously deselected package sffmpeg.
    (Reading database ... 60348 files and directories currently installed.)
    Unpacking sffmpeg (from sffmpeg_1.0.0_amd64.deb) ...
    Setting up sffmpeg (1.0.0) ...
