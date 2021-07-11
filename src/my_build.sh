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

# make.bash 中实际开始进行 go 编译的命令
# ./cmd/dist/dist bootstrap -a -v
#
# make.bash 中修改了的环境变量
#
# export GOBUILDTIMELOGFILE="../../build.log"
# export GOROOT_BOOTSTRAP="/usr/local/go"
#
# export GOENV=off
# unset GOBIN
# unset GOFLAGS
#
# GOROOT="$GOROOT_BOOTSTRAP"
# GOOS=""
# GOARCH=""
# GO111MODULE=off
############################################ make.bash execute END ############################################

############################################ 学习笔记 ############################################
#
# set -e 在 set -e 之后出现的代码，一旦出现了返回值非零，整个脚本就会立即退出
# -e 还有另一种写法 -o errexit
# set +e 表示关闭 -e 选项，set -e 表示重新打开 -e 选项。
# set +e 还有一种方法是使用 command || true
#
# unset 命令用于删除变量或函数(仅在当前终端删除 不是全局删除) -f 仅删除函数 -v 仅删除变量
#
# : ${VAR:="some default"}
# : ${VAR:="some default"} ${VAR2:=42} ${VAR3:=$LOGNAME}
# 在这个表达式中，如果变量 VAR 还没有被设置，那么 := 之后表达式的值将被赋给它，这个值可能是一个数字，一个字符串，或者是另外一个变量。
#
# := 句法
# username=""
# echo "${username:=$LOGNAME}"
# 只有当变量 username 已被定义，而且有一个实际的非空值时，变量 username 才不会被设置为变量 LOGNAME 的值。
# 和前例的主要不同是使用活动命令（echo）而不是被动的冒号来设置变量的默认值，当活动命令被调用时，默认赋值仍然会执行，并输出显示结果。
#
# = 句法
# username=""
# echo "${username=$LOGNAME}"
# 和前面一样，变量 username 已经被定义，但是它的值为空。在这个句法中，命令将会输出 echo 之后语句的执行结果。
# 因为变量 username 虽然为空值，但已经被定义了，所以除了一个回车不会再有其他输出。
# 只有当 username 变量完全没有定义时，才会将其设置为变量 LOGNAME 的值。
#
# :- 句法
# 在这个命令中，因为变量 username 虽然已被定义但是为空值，echo 语句将使用 LOGNAME 变量的值。
# username=""
# echo "${username:-$LOGNAME}"
# 这里 username 变量的值保持不变。这个命令和使用 = 句语法的不同之处是，在此命令被执行前，仅仅在代码中的 ${} 句法中做替换。
# 也就是说，echo 命令将输出 LOGNAME 变量的值，但是这个值不会被赋给 username 变量。
#
# - 句法
# username=""
# echo "${username-$LOGNAME}"
# :- 语句变成 - 的时候，因为 username 变量已被定义，输出将为空。如果未定义，就会使用LOGNAME变量的值。
# 还有一点也与 :- 句法相同，即 username 变量的值没有改变。
#
# :? 句法
# username=""
# echo "${username:?$LOGNAME}"
# 使用 :? 句法时，如果 username 变量已被定义为非空值，在 echo 命令中就会使用 username 变量的值。
# 如果 username 变量已被定义但却没有一个真正的值（也就是说非空）或者完全未被定义，那么在 echo 命令中就会使用 LOGNAME 的值，并且脚本退出执行。
# 如果把问号字符的参数改为某种错误字符，那这个语句就会在代码调试和查找未定义变量时变得很有用。
# 这段代码不仅仅输出字符串，而且会显示代码在脚本中所在行的位置。
#
# ? 句法
# username=""
# echo "${username?$LOGNAME}"
# 从 :? 句法中去掉冒号使用 username 变量不必一定为非空值。
# 如果 username 只被设置为一个空值，那么将使用这个空值。
# 相反的，如果 username 变量没有被定义，则同前所述的 :? 句法，执行 LOGNAME 替换，脚本退出运行，并显示退出时所在代码行在脚本中的位置。
#
# :+ 句法
# 和前面的例子相比，这个句法有相反的作用。这是因为，只有当变量已被定义而不是未定义的时候，"${}" 表达式才执行替换。
# username=""
# echo "${username:+$LOGNAME}"
# 如果这里的username变量已被定义而且非空，因此使用LOGNAME的值。如果 username 变量未定义，或者已定义但为空，则将使用空值。
# 在任何情况下，username 变量的值都不会改变。
#
# + 句法
# username=""
# echo "${username+$LOGNAME}"
# 如果前例 :+ 中的冒号，一旦变量 username 被定义，"${}" 表达式都将使用 LOGNAME 的值
# 进行这个替换时，username 变量不需要有一个实际的值（即非空值）。
#
# if [ -f file ] 如果文件存在
# if [ -d path ] 如果目录存在
# if [ -s file ] 如果文件存在且非空
# if [ -r file ] 如果文件存在且可读
# if [ -w file ] 如果文件存在且可写
# if [ -x file ] 如果文件存在且可执行
#
# $* 传递给脚本或函数的所有参数。
# $@ 传递给脚本或函数的所有参数。被双引号(" ")包含时，与 $* 稍有不同，下面将会讲到。
# $* 和 $@ 的区别
# $* 和 $@ 都表示传递给函数或脚本的所有参数，不被双引号(" ")包含时，都以"$1" "$2" … "$n" 的形式输出所有参数。
# 但是当它们被双引号(" ")包含时，
# "$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；
# "$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。
############################################ 学习笔记 END ############################################
