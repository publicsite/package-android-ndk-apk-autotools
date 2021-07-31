#!/bin/sh

mkdir dxclasses
javac $(find AndroidDx/src/main -name "*.java") -d dxclasses
printf "Main-Class: com.android.dx.command.Main\n\n" > manifest.txt
jar cfm dx.jar manifest.txt -C dxclasses com

##run with
##java -jar dx.jar