#
# Build file to create one big executable / shared library
# with aidl, aapt, zipalign and all depending libs
#

LOCAL_PATH := $(call my-dir)


#############################################################################
# libpng definitions
#############################################################################

libpng_SRC_FILES := \
	libpng/jni/png.c \
	libpng/jni/pngerror.c \
	libpng/jni/pngget.c \
	libpng/jni/pngmem.c \
	libpng/jni/pngpread.c \
	libpng/jni/pngread.c \
	libpng/jni/pngrio.c \
	libpng/jni/pngrtran.c \
	libpng/jni/pngrutil.c \
	libpng/jni/pngset.c \
	libpng/jni/pngtrans.c \
	libpng/jni/pngwio.c \
	libpng/jni/pngwrite.c \
	libpng/jni/pngwtran.c \
	libpng/jni/pngwutil.c

libpng_SRC_FILES_arm := \
			arm/arm_init.c \
			arm/filter_neon.S \
			arm/filter_neon_intrinsics.c

libpng_SRC_FILES_arm64 := $(libpng_SRC_FILES_arm)

libpng_C_INCLUDES := $(LOCAL_PATH)/libpng/jni

libpng_CFLAGS := -ftrapv -std=gnu89 #-fvisibility=hidden ## -fomit-frame-pointer

ifeq ($(ARCH_ARM_HAVE_NEON),true)
libpng_CFLAGS_arm := -DPNG_ARM_NEON_OPT=2
endif

libpng_CFLAGS_arm64 := -DPNG_ARM_NEON_OPT=2

# BUG: http://llvm.org/PR19472 - SLP vectorization (on ARM at least) crashes
# when we can't lower a vectorized bswap.
libpng_CFLAGS_arm += -fno-slp-vectorize


#############################################################################
# expat definitions
#############################################################################

expat_SRC_FILES := \
	expat/jni/lib/xmlparse.c \
	expat/jni/lib/xmlrole.c \
	expat/jni/lib/xmltok.c

expat_C_INCLUDES := $(LOCAL_PATH)/expat/jni/lib

expat_CFLAGS := \
    -fexceptions \
    -DHAVE_EXPAT_CONFIG_H
#    -Wall \
#    -Wmissing-prototypes -Wstrict-prototypes \
#    -Wno-unused-parameter -Wno-missing-field-initializers \


#############################################################################
# liblog definitions
#############################################################################

ifneq ($(TARGET_USES_LOGD),false)
liblog_SRC_FILES := liblog/jni/logd_write.c
else
liblog_SRC_FILES := liblog/jni/logd_write_kern.c
endif

liblog_C_INCLUDES := $(LOCAL_PATH)/liblog/jni/include #$(LOCAL_PATH)/libcutils/jni/include

liblog_CFLAGS := -DHAVE_PTHREADS


#############################################################################
# libcutils definitions
#############################################################################

libcutils_SRC_FILES := \
	libcutils/jni/hashmap.c \
	libcutils/jni/atomic.c.arm \
	libcutils/jni/native_handle.c \
	libcutils/jni/config_utils.c \
	libcutils/jni/cpu_info.c \
	libcutils/jni/load_file.c \
	libcutils/jni/open_memstream.c \
	libcutils/jni/strdup16to8.c \
	libcutils/jni/strdup8to16.c \
	libcutils/jni/record_stream.c \
	libcutils/jni/process_name.c \
	libcutils/jni/threads.c \
	libcutils/jni/sched_policy.c \
	libcutils/jni/iosched_policy.c \
	libcutils/jni/str_parms.c \
    libcutils/jni/android_reboot.c \
    libcutils/jni/ashmem-dev.c \
    libcutils/jni/debugger.c \
    libcutils/jni/klog.c \
    libcutils/jni/memory.c \
    libcutils/jni/partition_utils.c \
    libcutils/jni/properties.c \
    libcutils/jni/qtaguid.c \
    libcutils/jni/trace.c \
    libcutils/jni/uevent.c

libcutils_C_INCLUDES := $(LOCAL_PATH)/libcutils/jni/include

ifeq ($(TARGET_CPU_SMP),true)
    libcutils_targetSmpFlag := -DANDROID_SMP=1
else
    libcutils_targetSmpFlag := -DANDROID_SMP=0
endif

libcutils_CFLAGS := $(libcutils_targetSmpFlag) \
	-DHAVE_PTHREADS \
	-DHAVE_SCHED_H \
	-DHAVE_SYS_UIO_H \
	-DHAVE_ANDROID_OS \
	-DHAVE_IOCTL \
	-DHAVE_TM_GMTOFF


#############################################################################
# libhost definitions
#############################################################################

libhost_SRC_FILES:= \
	libhost/jni/CopyFile.c \
	libhost/jni/pseudolocalize.cpp

libhost_C_INCLUDES := $(LOCAL_PATH)/libhost/jni/include

ifeq ($(HOST_OS),cygwin)
libhost_CFLAGS += -DWIN32_EXE
endif
ifeq ($(HOST_OS),windows)
  ifeq ($(USE_MINGW),)
    # Case where we're building windows but not under linux (so it must be cygwin)
    libhost_CFLAGS += -DUSE_MINGW
  endif
endif
ifeq ($(HOST_OS),darwin)
libhost_CFLAGS += -DMACOSX_RSRC
endif


#############################################################################
# libutils definitions
#############################################################################
libutils_SRC_FILES := \
	libutils/jni/BasicHashtable.cpp \
	libutils/jni/BlobCache.cpp \
	libutils/jni/CallStack.cpp \
	libutils/jni/FileMap.cpp \
	libutils/jni/JenkinsHash.cpp \
	libutils/jni/LinearAllocator.cpp \
	libutils/jni/LinearTransform.cpp \
	libutils/jni/Log.cpp \
	libutils/jni/NativeHandle.cpp \
	libutils/jni/Printer.cpp \
	libutils/jni/ProcessCallStack.cpp \
	libutils/jni/PropertyMap.cpp \
	libutils/jni/RefBase.cpp \
	libutils/jni/SharedBuffer.cpp \
	libutils/jni/Static.cpp \
	libutils/jni/StopWatch.cpp \
	libutils/jni/String8.cpp \
	libutils/jni/String16.cpp \
	libutils/jni/SystemClock.cpp \
	libutils/jni/Threads.cpp \
	libutils/jni/Timers.cpp \
	libutils/jni/Tokenizer.cpp \
	libutils/jni/Unicode.cpp \
	libutils/jni/VectorImpl.cpp \
	libutils/jni/misc.cpp \
	libutils/jni/Looper.cpp \
	libutils/jni/Trace.cpp

libutils_C_INCLUDES += $(LOCAL_PATH)/libutils/jni/include
#	libutils_C_INCLUDES += bionic/libc

libutils_CFLAGS += -DHAVE_ENDIAN_H -DHAVE_ANDROID_OS -DHAVE_PTHREADS -DHAVE_SYS_UIO_H -DHAVE_POSIX_FILEMAP

ifeq ($(TARGET_ARCH),mips)
libutils_CFLAGS += -DALIGN_DOUBLE
endif

#############################################################################
# aapt definitions
#############################################################################

aapt_SRC_FILES := JNImain.c \
	aapt/jni/Main.cpp \
    aapt/jni/AaptAssets.cpp \
    aapt/jni/AaptConfig.cpp \
    aapt/jni/AaptUtil.cpp \
    aapt/jni/AaptXml.cpp \
    aapt/jni/ApkBuilder.cpp \
    aapt/jni/Command.cpp \
    aapt/jni/CrunchCache.cpp \
    aapt/jni/FileFinder.cpp \
    aapt/jni/Package.cpp \
    aapt/jni/StringPool.cpp \
    aapt/jni/XMLNode.cpp \
    aapt/jni/ResourceFilter.cpp \
    aapt/jni/ResourceIdCache.cpp \
    aapt/jni/ResourceTable.cpp \
    aapt/jni/Images.cpp \
    aapt/jni/Resource.cpp \
    aapt/jni/pseudolocalize.cpp \
    aapt/jni/SourcePos.cpp \
    aapt/jni/WorkQueue.cpp \
    aapt/jni/ZipEntry.cpp \
    aapt/jni/ZipFile.cpp \
    aapt/jni/qsort_r_compat.c

aapt_C_INCLUDES := libpng/jni
#    bionic \
#    stlport/stlport

aapt_CFLAGS += -Wno-format-y2k -DSTATIC_ANDROIDFW_FOR_TOOLS


#############################################################################
# put it all together
#############################################################################

include $(CLEAR_VARS)
LOCAL_MODULE:= libaaptcomplete

LOCAL_SRC_FILES += $(libpng_SRC_FILES)
LOCAL_SRC_FILES += $(expat_SRC_FILES)
LOCAL_SRC_FILES += $(liblog_SRC_FILES)
LOCAL_SRC_FILES += $(libcutils_SRC_FILES)

LOCAL_SRC_FILES_arm   += libcutils/jni/arch-arm/memset32.S
LOCAL_SRC_FILES_arm64 += libcutils/jni/arch-arm64/android_memset.S
LOCAL_SRC_FILES_mips  += libcutils/jni/arch-mips/android_memset.c
LOCAL_SRC_FILES_x86   += \
        libcutils/jni/arch-x86/android_memset16.S \
        libcutils/jni/arch-x86/android_memset32.S
LOCAL_SRC_FILES_x86_64 += \
        libcutils/jni/arch-x86_64/android_memset16_SSE2-atom.S \
        libcutils/jni/arch-x86_64/android_memset32_SSE2-atom.S
LOCAL_CFLAGS_arm    += -DHAVE_MEMSET16 -DHAVE_MEMSET32
LOCAL_CFLAGS_arm64  += -DHAVE_MEMSET16 -DHAVE_MEMSET32
LOCAL_CFLAGS_mips   += -DHAVE_MEMSET16 -DHAVE_MEMSET32
LOCAL_CFLAGS_x86    += -DHAVE_MEMSET16 -DHAVE_MEMSET32
LOCAL_CFLAGS_x86_64 += -DHAVE_MEMSET16 -DHAVE_MEMSET32

LOCAL_SRC_FILES += $(libhost_SRC_FILES)
LOCAL_SRC_FILES += $(libutils_SRC_FILES)
LOCAL_SRC_FILES += $(aapt_SRC_FILES)

LOCAL_C_INCLUDES += $(libpng_C_INCLUDES)
LOCAL_C_INCLUDES += $(expat_C_INCLUDES)
LOCAL_C_INCLUDES += $(liblog_C_INCLUDES)
LOCAL_C_INCLUDES += $(libcutils_C_INCLUDES)
LOCAL_C_INCLUDES += $(libhost_C_INCLUDES)
LOCAL_C_INCLUDES += $(libutils_C_INCLUDES)
LOCAL_C_INCLUDES += $(aapt_C_INCLUDES)

LOCAL_CFLAGS += $(libpng_CFLAGS)
LOCAL_CFLAGS += $(expat_CFLAGS)
LOCAL_CFLAGS += $(liblog_CFLAGS)
LOCAL_CFLAGS += $(libcutils_CFLAGS)
LOCAL_CFLAGS += $(libhost_CFLAGS)
LOCAL_CFLAGS += $(libutils_CFLAGS)
LOCAL_CFLAGS += $(aapt_CFLAGS)

LOCAL_LDLIBS += -lz -llog

# Building a commandline executable for Android
# include $(BUILD_EXECUTABLE)

# Building a shared library for Android
include $(BUILD_SHARED_LIBRARY)

