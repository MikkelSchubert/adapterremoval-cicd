#!/bin/sh
set -euo # "strict" mode
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

sudo apt-get install -y \
	libisal-dev \
	libdeflate-dev
