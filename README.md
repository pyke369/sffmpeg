# Static FFmpeg Build
`sffmpeg` is a simple CMake-based full-featured FFmpeg build helper.

It currently works on Linux and other POSIX systems (with a few tweaks). It has been tested the most heavily on Linux/x86_64
(Ubuntu 18.04). This helper is regularly updated with the latest versions of the FFmpeg dependencies, and provides an effective
way to build, test and compare multiple versions of FFmpeg on the same machine.

## Build Dependencies
`sffmpeg` requires the following software to be installed in order to build:

- a recent version of [cmake](http://www.cmake.org/) (3.6+)
- a recent version of [gcc/g++](http://gcc.gnu.org/) (7.x+)
- the [autoconf](http://www.gnu.org/software/autoconf/), [automake](http://www.gnu.org/software/automake/) and [libtool](http://www.gnu.org/software/libtool/) utilities
- the [pkg-config](http://www.freedesktop.org/wiki/Software/pkg-config/) utility
- the [gperf](https://www.gnu.org/software/gperf/) utility (needed for fontconfig support)
- the [xorg-macros](https://github.com/freedesktop/xorg-macros/) bundle (needed for Intel Media SDK/QuickSync Video support)

A dependencies check is automatically performed and the build is aborted if a dependency is missing.

## Usage
Just type the following commands at the shell prompt:

    $ git clone https://github.com/pyke369/sffmpeg
    $ cd sffmpeg
    $ make

Then go grab a coffee (or maybe ten). The helper will compile all FFmpeg dependencies for you. Once done, you should get an
FFmpeg binary in the `build/bin` directory (with all dependencies statically linked-in).
```
$ build/bin/ffmpeg
ffmpeg version 4.4 Copyright (c) 2000-2021 the FFmpeg developers
  libavutil      56. 70.100 / 56. 70.100
  libavcodec     58.134.100 / 58.134.100
  libavformat    58. 76.100 / 58. 76.100
  libavdevice    58. 13.100 / 58. 13.100
  libavfilter     7.110.100 /  7.110.100
  libswscale      5.  9.100 /  5.  9.100
  libswresample   3.  9.100 /  3.  9.100
  libpostproc    55.  9.100 / 55.  9.100
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...
```
From there, you may use the binary immediately or build a Debian package for later deployment (see below).

## Packaging
(requires the `devscripts` package)

You may optionally build a Debian package by typing the following command at the shell prompt:
```
$ make deb
```

The `ffmpeg`, `ffprobe` and `frmxtract` binaries will be installed by the package in the `/usr/local/bin` directory.
```
$ sudo dpkg -i ../sffmpeg_4.4_amd64.deb
Selecting previously unselected package sffmpeg.
Unpacking sffmpeg (4.4) ...
Setting up sffmpeg (4.4) ...
```
