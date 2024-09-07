#!/bin/bash

sudo apt update

sudo apt install mkisofs -y

rm *.iso *.img || true


#mkisofs -o output.iso -V CDRV prebuilts/turbocpp/
genisoimage -o turbocpp.img -R -J -V "TurboCPP" /workspace/TurboCPP-Web/prebuilts/turbocpp
mtools -i turbocpp.img -c "mformat a: -F -C -B 2048 -S 512 -h 16 -t 63"
mtools -i turbocpp.img -c "mcopy -s $(realpath .)/prebuilts/turbocpp/* a:"