#!/usr/bin/env bash
set -euo pipefail

: ${1:?filename argument missing}
xml_db_file="${1}"
test -f ${xml_db_file} || {
    printf "%s: no such file\n" ${xml_db_file} >&2
    exit 1
}

tmpdir=$(mktemp -d)
trap "rm -rf \"$tmpdir\"" EXIT

xmllint \
    --xpath '/*[local-name()="mime-info"]/*[local-name()="mime-type"]/@type' \
    ${xml_db_file} >"$tmpdir/actual-types"

LC_ALL=C.UTF-8 sort --ignore-case "$tmpdir/actual-types" >"$tmpdir/sorted-types"

diff -u "$tmpdir/actual-types" "$tmpdir/sorted-types" || {
    cat <<\EOF
*****************************************************************
** Database is not sorted by type, fix according to above diff **
*****************************************************************
EOF
    exit 1
}
