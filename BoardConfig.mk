#
# Copyright (C) 2022-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/rtwo

# Inherit from motorola sm8550-common
include device/motorola/sm8550-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := rtwo

# Display
TARGET_SCREEN_DENSITY := 400

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix_rtwo.xml
DEVICE_MANIFEST_KALAMA_FILES += $(DEVICE_PATH)/manifest_rtwo.xml
ODM_MANIFEST_SKUS += dn dne
ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/manifest_rtwo_dn.xml
ODM_MANIFEST_DNE_FILES := $(DEVICE_PATH)/manifest_rtwo_dne.xml

# Kernel
TARGET_KERNEL_CONFIG += \
	vendor/ext_config/moto-kalama-rtwo.config

# Kernel Modules
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.system_dlkm))
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist.vendor_boot
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery $(DEVICE_PATH)/modules.load.vendor_ramdisk))
SYSTEM_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.load.system_dlkm))

# Partitions
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 3318226944
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 873680896
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 916299776
endif
BOARD_MOT_DP_GROUP_SIZE := 9936306176 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_SIZE := 9940500480

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
VENDOR_SECURITY_PATCH := 2024-09-01

# inherit from the proprietary version
include vendor/motorola/rtwo/BoardConfigVendor.mk
