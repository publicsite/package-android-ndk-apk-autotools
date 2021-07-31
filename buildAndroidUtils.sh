#!/bin/sh

cd android-utils

./autogen.sh

CXXFLAGS="-fpermissive" ./configure

CXXFLAGS="-fpermissive" make

#To create an apk

#aapt.exe package -f -m -J src -M AndroidManifest.xml -S res -A assets  -0 "" -I android.jar -F MyApp.apk

#Where AndroidManifest.xml is a normal xml (ie. not axml)

#https://stackoverflow.com/questions/11367314/how-to-convert-xml-to-android-binary-xml
