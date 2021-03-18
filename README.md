# Static FFmpeg Build
`sffmpeg` is a simple cmake-based full-featured FFmpeg build helper.

It currently works on Linux and other POSIX systems (with a few tweaks). It has been tested the most heavily on Linux/x86_64
(Ubuntu 18.04).  The helper will grab the latest versions of most FFmpeg dependencies, providing a way to effectively build,
test and compare multiple builds of FFmpeg on the same host.

## Requirements
`sffmpeg` requires:

- a POSIX-compliant system (virtually any system today)
- a recent version of [gcc](http://gcc.gnu.org/)
- a recent version of [cmake](http://www.cmake.org/) (3.6+)
- the [autoconf](http://www.gnu.org/software/autoconf/) and [libtool](http://www.gnu.org/software/libtool/) utilities
- the [pkg-config](http://www.freedesktop.org/wiki/Software/pkg-config) utility

## Usage
Just type the following commands at the shell prompt:

    $ git clone https://github.com/pyke369/sffmpeg
    $ cd sffmpeg
    $ make

Then go grab a coffee (or maybe ten). The helper will compile all FFmpeg dependencies for you. Once done, you should get an
FFmpeg binary in the `build/bin` directory (with all dependencies statically linked-in).
```
$ build/bin/ffmpeg
ffmpeg version 4.3.2 Copyright (c) 2000-2021 the FFmpeg developers
  libavutil      56. 51.100 / 56. 51.100
  libavcodec     58. 91.100 / 58. 91.100
  libavformat    58. 45.100 / 58. 45.100
  libavdevice    58. 10.100 / 58. 10.100
  libavfilter     7. 85.100 /  7. 85.100
  libswscale      5.  7.100 /  5.  7.100
  libswresample   3.  7.100 /  3.  7.100
  libpostproc    55.  7.100 / 55.  7.100
Hyper fast Audio and Video encoder
usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...
```
From there, you may use the binary immediately or build a Debian package for later deployment (see below).

## Packaging
(requires devscripts package)

You may optionally build a Debian package by typing the following command at the shell prompt:
```
$ make deb
```

The `ffmpeg`, `ffprobe` and `frmxtract` binaries will be installed by the package in the `/usr/local/bin` directory.
```
$ sudo dpkg -i ../sffmpeg_4.3.2_amd64.deb
Selecting previously unselected package sffmpeg.
Unpacking sffmpeg (4.3.2) ...
Setting up sffmpeg (4.3.2) ...
```
