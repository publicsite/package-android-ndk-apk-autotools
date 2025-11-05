#!/bin/sh

OLD_UMASK="$(umask)"
umask 0022

if ! [ -d "${PWD}/AndroidDx" ]; then
	git clone https://github.com/rover12421/AndroidDx
fi

umask "${OLD_UMASK}"
