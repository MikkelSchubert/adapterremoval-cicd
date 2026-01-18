#!/bin/sh
set -euo # "strict" mode
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

echo RUNNING SETUP
# WORKAROUND for empty `$@` failing with `set -u` on OSX
if test $# -gt 0; then
    make setup "PREFIX=${PWD}/build/install" "${@}"
else
    make setup "PREFIX=${PWD}/build/install"
fi

echo RUNNING COMPILE
make executables

echo RUNNING UNIT-TESTS
gdb -batch -ex "run" -ex "bt" build/tests/unit/unit_tests --break 2>&1 | grep -v "^No stack.$"

echo RUNNING TESTS
make regression-tests

echo RUNNING INSTALL
make install

echo RUNNING EXAMPLES
make -C examples EXE="${PWD}/build/src/adapterremoval3"
