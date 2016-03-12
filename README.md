# Static FFmpeg Build

[![Build Status](https://travis-ci.org/pyke369/sffmpeg.svg?branch=master)](https://travis-ci.org/pyke369/sffmpeg)

`sffmpeg` is a simple cmake-based full-featured FFmpeg build helper.

It currently works on Linux, OpenBSD, FreeBSD, and MacOSX. It has been tested the most heavily on Linux/x86_64 (Ubuntu 14.04).
The helper will grab the latest versions of most FFmpeg dependencies, providing a way to effectively build, test and compare
multiple builds of FFmpeg on the same host.

## Requirements

`sffmpeg` requires:

- a POSIX-compliant system (virtually any system today).
- a recent version of [gcc](http://gcc.gnu.org/).
- a recent version of [cmake](http://www.cmake.org/) (2.8.8+, with proper git and mercurial bindings).
- the [autoconf](http://www.gnu.org/software/autoconf/) and [libtool](http://www.gnu.org/software/libtool/) utilities.
- the [pkg-config](http://www.freedesktop.org/wiki/Software/pkg-config) utility.

## Usage

Just type the following commands at the shell prompt:

    $ git clone https://github.com/pyke369/sffmpeg
    $ cd sffmpeg
    $ make

Then go grab a coffee (or maybe two). The helper will download and compile all FFmpeg dependencies for you.
Once done, you should get a FFmpeg binary in the `build/bin` directory (with all dependencies statically linked-in).


    ffmpeg version 3.0 Copyright (c) 2000-2016 the FFmpeg developers
      libavutil      55. 17.103 / 55. 17.103
      libavcodec     57. 24.102 / 57. 24.102
      libavformat    57. 25.100 / 57. 25.100
      libavdevice    57.  0.101 / 57.  0.101
      libavfilter     6. 31.100 /  6. 31.100
      libswscale      4.  0.100 /  4.  0.100
      libswresample   2.  0.101 /  2.  0.101
      libpostproc    54.  0.100 / 54.  0.100
    Hyper fast Audio and Video encoder
    usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

    Use -h to get full help or, even better, run 'man ffmpeg'


From there, you may use the binary immediately or build a Debian package for later deployment (see below).

## Packaging

(requires devscripts package)

You may optionally build a Debian package by typing the following command at the shell prompt:

    $ make deb

The `ffmpeg`, `ffprobe` and `frmxtract` binaries will be installed by the package in the `/usr/bin` directory.

    $ sudo dpkg -i sffmpeg_3.0_amd64.deb
    Selecting previously unselected package sffmpeg.
    Unpacking sffmpeg (from sffmpeg_3.0_amd64.deb) ...
    Setting up sffmpeg (3.0) ...

