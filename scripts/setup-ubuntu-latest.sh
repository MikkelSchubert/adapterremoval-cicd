#!/bin/sh
set -euo # "strict" mode
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

sudo apt-get install -y \
	build-essential \
	libdeflate-dev \
	libisal-dev \
	meson \
	ninja-build \
	pkgconf \
	python3 \
	python3-jsonschema \
	python3-sphinx
