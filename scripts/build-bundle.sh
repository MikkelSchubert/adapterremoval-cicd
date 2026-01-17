#!/bin/sh
set -euo # "strict" mode
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

PREFIX=$1
TARGET=$2

mkdir -p "${TARGET}"
mv -v "${PREFIX}/bin/adapterremoval3" "${TARGET}/"
mv -v "${PREFIX}/share/adapterremoval3/examples" "${TARGET}/examples"
mv -v "${PREFIX}/share/adapterremoval3/docs/html" "${TARGET}/docs"
mv -v "${PREFIX}/share/man/man1/adapterremoval3.1" "${TARGET}/docs/"

for exe in adapterremoval3 adapterremoval3.exe; do
    if test -e "${TARGET}/${exe}"; then
        strip "${TARGET}/${exe}"
    fi
done

if test -e "/ucrt64/bin/libdeflate.dll"; then
    cp "/ucrt64/bin/libdeflate.dll" "${TARGET}"
    cp "/ucrt64/share/licenses/libdeflate/COPYING" "${TARGET}/docs/libdeflate.COPYING"
fi

tar cvzf "${TARGET}.tar.gz" "${TARGET}"
