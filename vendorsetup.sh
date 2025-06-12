#
# This file is part of the PitchBlack Recovery Project
# Adapted from OrangeFox for PBRP use by <YourName>
#

FDEVICE="water"

pbrp_get_target_device() {
  local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
  if [ -n "$chkdev" ]; then
    PB_BUILD_DEVICE="$FDEVICE"
  else
    chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
    [ -n "$chkdev" ] && PB_BUILD_DEVICE="$FDEVICE"
  fi
}

if [ -z "$1" -a -z "$PB_BUILD_DEVICE" ]; then
  pbrp_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$PB_BUILD_DEVICE" = "$FDEVICE" ]; then
  export TW_DEFAULT_LANGUAGE="en"
  export LC_ALL="C"
  export ALLOW_MISSING_DEPENDENCIES=true

  export PBRP_DEVICE="$FDEVICE"

  # Partitions (check correctness with AOSP device tree or TWRP build logs)
  export PBRP_INSTALL_PARTITION="/dev/block/platform/bootdevice/by-name/boot"
  export PBRP_SYSTEM_PARTITION="/dev/block/mapper/system"
  export PBRP_VENDOR_PARTITION="/dev/block/mapper/vendor"
  # Optional
  # export PBRP_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"

  # Basic info
  export PITCH_BLACK_BUILD=1
  export TARGET_DEVICE_ALT="water,cloud"
  export PB_TARGET_DEVICES="water,cloud"

  # UI & Appearance
  export PB_SCREEN_HEIGHT=1600
  export PB_STATUSBAR_HEIGHT=80
  export PB_STATUS_INDENT_LEFT=48
  export PB_STATUS_INDENT_RIGHT=48
  export PB_CLOCK_POS=1

  # Features
  export PB_DISABLE_DEFAULT_DM_VERITY=1
  export PB_DISABLE_FORCED_ENCRYPTION=1
  export PB_NO_TREBLE_COMPATIBILITY_CHECK=1
  export PB_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
  export PB_ENABLE_APP_MANAGER=1
  export PB_USE_TAR_BINARY=1
  export PB_USE_SED_BINARY=1
  export PB_USE_XZ_UTILS=1
  export PB_ASH_IS_BASH=1
  export PB_USE_BASH_SHELL=1
  export PB_ALLOW_DISABLE_NAVBAR=0
  export PB_DELETE_AROMAFM=1
  export PB_DELETE_MAGISK_ADDON=1
  export PB_PATCH_AVB20=1
  export PB_QUICK_BACKUP_LIST="/boot;/data;"

  # OTA & updates
  export PB_OTA_SUPPORT=1
  export PB_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
  export PB_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
  export PB_DISABLE_MIUI_OTA_BY_DEFAULT=1

  # Build info
  export PB_VERSION="12.1.0"
  export PB_BUILD_TYPE="Unofficial"
  export PB_MAINTAINER="Ninja"

  # Logging
  if [ -n "$PB_BUILD_LOG_FILE" -a -f "$PB_BUILD_LOG_FILE" ]; then
    export | grep "PB_" >> $PB_BUILD_LOG_FILE
    export | grep "TW_" >> $PB_BUILD_LOG_FILE
  fi
fi
