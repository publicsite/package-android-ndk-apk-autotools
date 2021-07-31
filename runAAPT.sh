#!/bin/sh
AAPT="${PWD}/android-utils/aapt/aapt"

mkdir bin
$AAPT package -x -M AndroidManifest.xml -S $PWD/res/ -F bin/framework-res.apk -vvv

cd bin
unzip framework-res.apk
rm AndroidManifest.xml

jar cf my.jar resources.arsc

cp -a ../project .

mv my.jar project/

cd project

$AAPT package -M AndroidManifest.xml -F My.apk -I my.jar lib
