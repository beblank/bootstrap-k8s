#!/bin/bash
#-ex
echo "Type the your mac address"
read MAC
DASHMAC = ${MAC//:/-}
curl --retry 10 "http://192.168.254.144:8080/ignition?mac=$DASHMAC&os=installed" -o ignition.json
coreos-install \
  -d /dev/sda \
  -C stable \
  -V current \
  -o "" \
  -b http://192.168.254.144:8080/assets/coreos \
  -i ignition.json
udevadm settle
systemctl reboot