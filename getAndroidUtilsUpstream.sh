#!/bin/sh

OLD_UMASK="$(umask)"
umask 0022

if [ -d "${PWD}/android-utils" ]; then
	rm -rf "${PWD}/android-utils"
fi

git clone https://github.com/cjacker/android-utils

#get rid of adb as this doesn't compile
#(see https://bugs.gentoo.org/697976)
rm -rf ./android-utils/adb
sed -i "s# adb##g" android-utils/Makefile.in
sed -i "s# adb##g" android-utils/Makefile.am
sed -i "s#adb##g" android-utils/README.md
sed -i "s#adb/Makefile##g" android-utils/configure.ac
rm -rf ./android-utils/autom4te.cache
rm android-utils/configure

sed -i "249,254d" android-utils/libutils/include/utils/Vector.h
sed -i "s#block.getComment(\&len) ? block.getComment(\&len)#block.getComment(\&len) ? (char16_t*)block.getComment(\&len)#g" android-utils/aapt/ResourceTable.cpp
sed -i "s#uint16_t\* ResStringPool::stringAt#char16_t\* ResStringPool::stringAt#g" android-utils/aapt/ResourceTypes.cpp

umask "${OLD_UMASK}"
