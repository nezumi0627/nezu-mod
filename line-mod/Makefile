export THEOS_DEVICE_IP = 127.0.0.1
export THEOS_DEVICE_PORT = 2222

ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = LINE

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NezuLineMod

NezuLineMod_FILES = Tweak.xm
NezuLineMod_FRAMEWORKS = UIKit
NezuLineMod_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
