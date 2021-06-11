#!/bin/bash 

echo -e "IP Address: \c"
read ip 

echo -e "Port: \c"
read port


devices=`v4l2-ctl --list-devices | awk '/v4l2/{getline; print}'`

PS3='Select device: '
select device in $devices
do
  echo "You have selected: $device"
  break
done

gst-launch-1.0 souphttpsrc location="http://$ip:$port/video" ! jpegdec ! videoconvert ! v4l2sink device=$device
