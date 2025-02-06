#!/bin/bash

set -x

TMPDIR="$(mktemp -d)"

OPTIONS=' -H --include=*.pl -n -r . '

grep "$@"    $OPTIONS >"${TMPDIR}/grep.txt"
grep -o -F "/*" $OPTIONS >"${TMPDIR}/commentopen.txt"
grep -o -F "/*" $OPTIONS >"${TMPDIR}/commentclose.txt"
grep -o "^ *%"  $OPTIONS >"${TMPDIR}/commentline.txt"


