#!/bin/bash

sudo apt update

sudo apt install mkisofs -y

rm *.iso *.img || true


mkisofs -o output.iso -V CDRV prebuilts/turbocpp/
