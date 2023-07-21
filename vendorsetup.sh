#!/usr/bin/env bash
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

FDEVICE="fleur"
#set -o xtrace

fox_get_target_device() {
	local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
	if [ -n "$chkdev" ]; then
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

# Dirty Fix: Only declare orangefox vars when needed
if [ -f "$(gettop)/bootable/recovery/orangefox.cpp" ]; then
	echo -e "\x1b[96m[INFO]: Setting up OrangeFox build vars for fleur...\x1b[m"
	if [ "$1" = "$FDEVICE" ] || [  "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
                # Build Environment
                export USE_CCACHE=1
                ccache -M 100G

		# Version / Maintainer infos
		export OF_MAINTAINER="Rohit Tiwari // RT1648"
                export OF_MAINTAINER_AVATAR="$PWD/device/xiaomi/fleur/maintainer.png"
		export FOX_VERSION=R12.1
		export FOX_BUILD_TYPE="Stable"
               
		# Device info
		export OF_AB_DEVICE=1
		export OF_VIRTUAL_AB_DEVICE=1
		export TARGET_DEVICE_ALT="miel"

		# Display / Leds
		export OF_SCREEN_H="2400"
		export OF_STATUS_H="100"
		export OF_STATUS_INDENT_LEFT=48
		export OF_STATUS_INDENT_RIGHT=48
		export OF_HIDE_NOTCH=1
		export OF_CLOCK_POS=1 # left and right clock positions available
		export OF_USE_GREEN_LED=0

		# Other OrangeFox configs
		export OF_ENABLE_LPTOOLS=1
		export OF_ALLOW_DISABLE_NAVBAR=0
                export OF_QUICK_BACKUP_LIST="/boot;/data;"
                export FOX_ENABLE_APP_MANAGER=1
		export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
                export OF_FLASHLIGHT_ENABLE=1
		export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1

		# Run a process after formatting data to work-around MTP issues
		export OF_RUN_POST_FORMAT_PROCESS=1

		# OTA for custom ROMs
                export OF_NO_MIUI_PATCH_WARNING=1
        	export OF_KEEP_DM_VERITY=1
	        export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
	        export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	        export OF_DISABLE_MIUI_OTA_BY_DEFAULT=0
 
  
fi
