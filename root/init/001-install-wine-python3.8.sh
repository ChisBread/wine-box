#!/usr/bin/env bash
set -ex
function pyok() {
    while :
    do
        NOTFOUND=`wine python --version | grep 3.8` || true
        if [ "$NOTFOUND" != "" ]; then
            rm python-3.8.10.exe
            break
        fi
        sleep 1
    done
}
pyok &
# download python-3.8.10.exe
wget https://www.python.org/ftp/python/3.8.10/python-3.8.10.exe
# start install
wine start python-3.8.10.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
wait