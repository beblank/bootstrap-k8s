#!/bin/bash

sudo docker run --rm --cap-add=NET_ADMIN --net=host quay.io/coreos/
dnsmasq \
-d -q \
--dhcp-range=192.168.254.100,192.168.254.130 \
--enable-tftp --tftp-root=/var/lib/tftpboot \
--dhcp-match=set:bios,option:client-arch,0 \
--dhcp-boot=tag:bios,undionly.kpxe \
--dhcp-match=set:efi32,option:client-arch,6 \
--dhcp-boot=tag:efi32,ipxe.efi \
--dhcp-match=set:efibc,option:client-arch,7 \
--dhcp-boot=tag:efibc,ipxe.efi \
--dhcp-match=set:efi64,option:client-arch,9 \
--dhcp-boot=tag:efi64,ipxe.efi \
--dhcp-userclass=set:ipxe,iPXE \
--dhcp-boot=tag:ipxe,http://192.168.254.128:8080/boot.ipxe \
--dhcp-host=00:0c:29:fd:d4:46,192.168.254.100,24h
--address=/tectonic/tectonic.example.com/10.44.227.100
--address=/matchbox.example.com/192.168.254.128 \
--log-queries \
--log-dhcp