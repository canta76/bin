#!/bin/sh

  SIZE=$(grep MemFree /proc/meminfo | awk '{print $2}')
  sleep 1
  echo "freemem: "$SIZE
  if [ "$SIZE" -gt "2000" ]; then
    echo "ram ok"
  else
    echo "ram low, kill comm process"
    /root/bin/pkill.sh comm/
    sleep 2
    echo "restarting comm"
    node /root/comm/comm.js > /dev/null 2>&1 &
  fi;
