# Dependencies:


## JAVA

platform  -> android-18.jar
compiler  -> ecj-4.5.jar
dexer     -> SDK\build-tools\23.0.0\lib\dx.jar
apk build -> sdklib-24.3.4.jar
signer    -> zipsigner-lib-1.17.jar
             zipsigner-lib-optional-1.17.jar
             zipio-lib-1.8.jar
             kellinwood-loggin-lib-1.1.jar
             sc-core-1.52.0.0.jar
             sc-prov-1.52.0.0.jar
             sc-pkix-1.52.0.0.jar
             sc-pg-1.52.0.0.jar


## NATIVE

host      -> Platform_Build\lib\host
zipalign  -> Platform_Build\tools\zipalign

libpng    -> Platform_External_Libpng
expat     -> Platform_External_Expat
zlib      -> Platform_External_Zlib

androidfw -> Platform_Framework_Base\include\androidfw
aapt      -> Platform_Framework_Base\tools\aapt
aidl      -> Platform_Framework_Base\tools\aidl

asset_manager.h -> Platform_Framework_Native\include\android
looper.h        -> Platform_Framework_Native\include\android

log.h     -> Platform_System_Core\include\android
cutils    -> Platform_System_Core\include\cutils
log       -> Platform_System_Core\include\log
utils     -> Platform_System_Core\include\utils

libcutils -> Platform_System_Core\libcutils
liblog    -> Platform_System_Core\liblog
libutils  -> Platform_System_Core\libutils


zopfli    -> zopfli\src

ld        -> Tool_Chain_Utils\binutils-2.25\ld



# STABLE APIs (at least api level 9)

https://developer.android.com/ndk/guides/stable_apis.html#a18

LOCAL_LDLIBS := -llog (liblog)

LOCAL_LDLIBS := -lz (zlib)

LOCAL_LDLIBS += -landroid (o.a. looper.h)

LOCAL_LDLIBS := -ldl (dynamic linker)
