#!/bin/sh
set -euo # "strict" mode
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

brew install \
	bash \
	gdb \
	isa-l \
	libdeflate \
	meson \
	mimalloc \
	ninja \
	sphinx-doc \
	uv
