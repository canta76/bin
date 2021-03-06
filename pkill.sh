#! /bin/sh
# This script can be used to kill a program by its name.
# Please install this script only if your operating system
# does not have such a command already.

if [ "$1" = "" ]; then
  echo "Usage: pkill name"
else        
  kill `ps | grep $1 | awk '{print $1}'`
  exit $?
fi

