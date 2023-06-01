#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/pb/config/common.mk)

# Inherit from fleur device
$(call inherit-product, device/xiaomi/fleur/device.mk)

PRODUCT_DEVICE := fleur
PRODUCT_NAME := twrp_fleur
PRODUCT_BRAND := xiaomi
PRODUCT_MODEL := fleur
PRODUCT_MANUFACTURER := xiaomi
