===LOG===

Regarding the skeleton file I wanted to generate for C on android using the NDK. I managed to use google's NDK with Replicant 4.2 SDK.

The first script below is the script I used. IIRC, native-activity example needed a little modification before compiling but good news that an old version was in the NDK, so it didn't need back-porting.

This generated NativeActivity-release-unsigned.apk

NativeActivity-release-unsigned.apk contained no java code (good news) and the C library. Bad news is it did contain a AndroidManifest.xml file. Unfortunately this is a compiled form of XML, some people call it AXML, which is unique to android.

People have made compilers and decompilers for this format. All of the compilers had a bad dependency tree. I couldn't find a good one. I was really looking for a compiler for AXML written in C. I did find a decompiler, (AXML to XML) see script #2.

So all it'd really require is somebody to write such a program to have a C/autotools toolchain in theory. Gentoo bionic has already been written.

I used aapt to generate a resources.asrc using package="android" in a Manifest.xml, based on frameworks_base/core/res, specifically frameworks_base/core/res/res/values/attrs.xml , frameworks_base/core/res/res/values/attrs_manifest.xml and frameworks_base/core/res/res/values/public.xml

I then unzipped the apk and created an android.jar containing this file.

That was enough to use in aapt, to generate an APK with compiled AndroidManifest.xml

I then looked for a standalone version of aapt.

I did find one, in the getAndroidUtils.sh script, but it segfaults when using "res"

I managed to fix the segfault.

The project is therefore completed:

It can bundle a native apk using autotools.

===HOW IT WORKS===

cd to the directory containing the sources

the script
	./getAndroidUtilsUpstream.sh
gets autotools android-util sources
for clarity, this has already been run and does not need running again

next run
	./buildAndroidUtils.sh
to build android-util sources

finally run
	./runAAPT.sh
to bundle the apk


a version of dx is also included, in the hope it can be used to create dalvik bytecode

the script
	./getDxUpstream.sh
gets dx tool from upstream
for clarity, this has already been run and does not need running again

next run
	./buildDx.sh
to build dx

to use, run
	java -jar dx.jar

==Directories and other files==

The directory, "project" contains the NDK application to be packaged, within that folder is the C/C++ binaries that have been linked against the bionic C library.
Modification can be done with a toolchain, for instance, using gentoo-bionic (which also uses autotools, if I understand  correctly).

Within the top level source folder is a AndroidManifest.xml and res directory. These are used for building a primitive android.jar by creating a resources.asrc
More information can be found at res/values/about.txt

==LICENCE==

in-keeping with the stuff in res/values. I have chosen to release this under the APACHE2 licence. A copy can found in LICENCE.TXT or at https://www.apache.org/licenses/LICENSE-2.0.txt

==DONATE==

https://www.paypal.com/donate/?hosted_button_id=SZABYRV48SAXW
