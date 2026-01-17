#!/bin/sh
set -euo # "strict" mode
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

uv pip install \
	meson \
	ninja \
	jsonschema \
	sphinx
