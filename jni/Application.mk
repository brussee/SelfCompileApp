NDK_TOOLCHAIN_VERSION := 4.9
APP_OPTIM    := debug #release
APP_STL      := gnustl_static #stlport_static #c++_static #gabi++_static
APP_MODULES  := libcutils libutils zipalign #expat libpng libhost #aidl #aapt
APP_ABI      := all
APP_PLATFORM := android-21