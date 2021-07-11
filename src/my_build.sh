#!/usr/bin/env bash

############################################ make.bash ENV ############################################

# Environment variables that control make.bash (17 个)

# GOROOT_FINAL: The expected final Go root, baked into binaries.
# The default is the location of the Go tree during the build.

# GOHOSTARCH: The architecture for host tools (compilers and
# binaries).  Binaries of this type must be executable on the current
# system, so the only common reason to set this is to set
# GOHOSTARCH=386 on an amd64 machine.

# GOARCH: The target architecture for installed packages and tools.

# GOOS: The target operating system for installed packages and tools.

# GO_GCFLAGS: Additional go tool compile arguments to use when
# building the packages and commands.

# GO_LDFLAGS: Additional go tool link arguments to use when
# building the commands.

# CGO_ENABLED: Controls cgo usage during the build. Set it to 1
# to include all cgo related files, .c and .go file with "cgo"
# build directive, in the build. Set it to 0 to ignore them.

# GO_EXTLINK_ENABLED: Set to 1 to invoke the host linker when building
# packages that use cgo.  Set to 0 to do all linking internally.  This
# controls the default behavior of the linker's -linkmode option.  The
# default value depends on the system.

# GO_LDSO: Sets the default dynamic linker/loader (ld.so) to be used
# by the internal linker.

# CC: Command line to run to compile C code for GOHOSTARCH.
# Default is "gcc". Also supported: "clang".

# CC_FOR_TARGET: Command line to run to compile C code for GOARCH.
# This is used by cgo.  Default is CC.

# CXX_FOR_TARGET: Command line to run to compile C++ code for GOARCH.
# This is used by cgo. Default is CXX, or, if that is not set,
# "g++" or "clang++".

# FC: Command line to run to compile Fortran code for GOARCH.
# This is used by cgo. Default is "gfortran".

# PKG_CONFIG: Path to pkg-config tool. Default is "pkg-config".

# GO_DISTFLAGS: extra flags to provide to "dist bootstrap".
# (Or just pass them to the make.bash command line.)

# GOBUILDTIMELOGFILE: If set, make.bash and all.bash write
# timing information to this file. Useful for profiling where the
# time goes when these scripts run.

export GOBUILDTIMELOGFILE="../../build.log"

# GOROOT_BOOTSTRAP: A working Go tree >= Go 1.4 for bootstrap.
# If $GOROOT_BOOTSTRAP/bin/go is missing, $(go env GOROOT) is
# tried for all "go" in $PATH. $HOME/go1.4 by default.

export GOROOT_BOOTSTRAP="/usr/local/go"

############################################ make.bash ENV END ############################################

############################################ make.bash execute ############################################

./make.bash -v

############################################ make.bash execute END ############################################
