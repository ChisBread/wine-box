#!/usr/bin/env bash
function skipsomething() {
    LAST="1"
    while :
    do
        xdotool search "$@"
        NOTFOUND=$?
        if [ "$LAST" == "0" ] && [ "$NOTFOUND" == "1" ]; then
            break
        fi
        echo "[skipsomething] find $@ : $NOTFOUND"
        if [ "$NOTFOUND" == "0" ]; then
            sleep 3
            xdotool key Tab
            sleep 0.5
            xdotool key Return
        fi
        LAST=$NOTFOUND
        sleep 0.2
    done
}
wget http://mirrors.ustc.edu.cn/wine/wine/wine-mono/8.0.0/wine-mono-8.0.0-x86.msi
wine msiexec /i wine-mono-8.0.0-x86.msi &
sleep 20
skipsomething "wine"
wait
sleep 5
rm wine-mono-8.0.0-x86.msi
