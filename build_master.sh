#!/bin/bash
if [ "${1}" = "skip" ] ; then
	device=$(echo $(\ls *.img) | sed s/.img//g)
	rm Zeta-kernel-$device-"$(cat version)".zip 2>/dev/null
	cp *.img kernelzip/boot.img
	cd kernelzip/
	7z a -mx9 Zeta-kernel-$device-"$(cat ../version)"-tmp.zip *
	zipalign -v 4 Zeta-kernel-$device-"$(cat ../version)"-tmp.zip ../Zeta-kernel-$device-"$(cat ../version)".zip
	rm Zeta-kernel-$device-"$(cat ../version)"-tmp.zip
	cd ..
	ls -al Zeta-kernel-$device-"$(cat version)".zip
	exit 0
fi

./build_clean.sh nozip
./build_kernel.sh CC='$(CROSS_COMPILE)gcc'

rm Zeta-kernel-N5-"$(cat version)".zip 2>/dev/null
cp boot.img kernelzip/boot.img
cd kernelzip/
7z a -mx9 Zeta-kernel-N5-"$(cat ../version)"-tmp.zip *
zipalign -v 4 Zeta-kernel-N5-"$(cat ../version)"-tmp.zip ../Zeta-kernel-N5-"$(cat ../version)".zip
rm Zeta-kernel-N5-"$(cat ../version)"-tmp.zip
cd ..
ls -al Zeta-kernel*.zip
