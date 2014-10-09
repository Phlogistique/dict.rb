#!/bin/sh
set -x -e -u

test -d $PREFIX/bin

EXE="$(readlink -f dict.rb)"
for i in E F B R K D; do
	ln -s "$EXE" "$PREFIX/bin/$i" ||:
done
