NDK_TOOLCHAIN_VERSION := 4.9
APP_OPTIM    := debug #release
APP_STL      := gnustl_static #stlport_static #gabi++_static #c++_static
APP_MODULES  := aidl aapt zipalign #expat libpng libcutils libutils libhost
APP_ABI      := armeabi armeabi-v7a x86 mips
APP_PLATFORM := android-18