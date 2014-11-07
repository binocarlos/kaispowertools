#!/bin/sh
export DISPLAY=:0
if [ "`/usr/bin/lsusb | /bin/grep -c ouse`" -ge 1 ]
then
  echo "mouse found - disabling touchpad";
  sudo /usr/bin/synclient TouchpadOff=1
#   /usr/bin/espeak touchpad_off
else 
  echo "mouse not found - enabling touchpad";
  sudo /usr/bin/synclient TouchpadOff=0
#   /usr/bin/espeak touchpad_on 
fi