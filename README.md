# STM32 Project Template

Kevin Cuzner

## Description

This is an attempt to have a very minimal project template that I can use for
creating new projects. I am going to attempt to keep it up to date with my
latest patterns and such.

This template has the files for the STM32F103, but it should be easy to
adapt to any STM32 whose cmsis device files are available (via STM32Cube).

## Prerequisites

The following Archlinux packages are required:

 - All the core build tools like make
 - arm-none-eabi-gcc
 - arm-none-eabi-binutils
 - arm-none-eabi-newlib
 - netcat
 - python (optional)

The following hardware is required

 - STLink v2

## Features

This is Makefile-based and has stubs for the following:

 - Basic build with the source in src.
 - Multiple build targets (by including common-top and common-bot and
   overriding the various settings in a per-directory Makefile. There isn't
   yet a good stub for actually initiating a multi-target build
 - Code generation. I have written several scripts for code generation and
   while I haven't included them in this project (since I might not need it
   for every project), I have left the commented-out stubs in the Makefiles.
 - Debugging with openocd and gdb

Included as a minimal codebase are the following:

 - The entirety of the standard CMSIS headers
 - STM32F103xB headers and startup files
 - atomic.h and macro_helpers.h
 - A very minimal main.c

## Usage

The entry point for building the project is in this root folder.

To build the project:

```
$ make
```

To clean the project build artifacts:

```
$ make clean
```

To flash the project binary:

```
$ make install
```

To debug:

```
$ make gdb
```

To stop the background openocd process that `make gdb` starts:

```
$ make stop
```

To start the background openocd process (not needed if using the `gdb` target)

```
$ make start
```

