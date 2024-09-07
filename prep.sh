#!/bin/bash

rm *.iso *.img || true


SIZE=$(du -sm --block-size=1M $(realpath .)/prebuilts/turbocpp | awk '{print $1}')

SIZE=$(( ($SIZE * 1024 * 1024) / 512 ))  # convert MB to sectors

mkdosfs -C turbocpp.img $SIZE

mcopy -i turbocpp.img -s $(realpath .)/prebuilts/turbocpp/* ::