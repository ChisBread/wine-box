#!/usr/bin/env bash
set -ex
for i in `ls /init/*|sort`
do
[ -x "$i" ] && {
    "$i"
}
done