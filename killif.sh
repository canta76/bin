#!/bin/sh

  SIZE=$(grep MemFree /proc/meminfo | awk '{print $2}')
  sleep 1
  echo "freemem: "$SIZE
  if [ "$SIZE" -gt "2000" ]; then
    echo "ram ok"
    # guardo se sta girando
    RES=$(ps | grep "comm/comm.js" | grep -v grep)
    echo "result: "$RES
    if [ "${#RES}" -gt 0 ];
    then
        echo "comm running"
    else
        echo "starting comm"
        node /root/comm/comm.js > /dev/null 2>&1 &
    fi
  else
    echo "ram low, kill comm processes"
    # faccio il kill di tutti i processi che contengo "comm/"
    /root/bin/pkill.sh comm/
    # kill anche di madplay che potrebbe essere in esecuzione
    /root/bin/pkill.sh madplay
    sleep 2
    echo "restarting comm"
    node /root/comm/comm.js > /dev/null 2>&1 &
  fi;
