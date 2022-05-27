#!/usr/bin/env bash
set -ex

RUN_XTERM=${RUN_XTERM:-no}
case $RUN_XTERM in
  false|no|n|0)
    sudo rm -f /etc/supervisord.d/xterm.conf
    ;;
esac
exec sudo -E bash -c 'supervisord -c /etc/supervisord.conf -l /var/log/supervisord.log'
