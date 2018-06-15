#!/bin/bash
#-ex
curl --retry 10 "http://192.168.254.144:8080/ignition?uuid=a82f4d56-498b-2b7b-7148-c1faca122ad4&mac=52-54-00-a1-9c-ae&os=installed" -o ignition.json
coreos-install \
  -d /dev/sda \
  -C stable \
  -V current \
  -o "" \
  -b http://192.168.254.144:8080/assets/coreos \
  -i ignition.json
udevadm settle
systemctl reboot