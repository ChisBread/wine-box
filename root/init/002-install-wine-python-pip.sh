#!/usr/bin/env bash
set -ex
function pipok() {
    while :
    do
        NOTFOUND=`wine python -m pip --version | grep 3.8` || true
        if [ "$NOTFOUND" != "" ]; then
            rm get-pip.py
            break
        fi
        sleep 1
    done
}
NOTFOUND=`wine python --version | grep 3.8` || true
if [ "$NOTFOUND" == "" ]; then
    echo 'python3.8 not found'
    exit 1
fi
pipok &
# download
wget https://bootstrap.pypa.io/get-pip.py
wine python get-pip.py
wait