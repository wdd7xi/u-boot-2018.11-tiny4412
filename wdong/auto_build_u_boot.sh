#!/bin/bash

echo "build_u_boot ..."
cd ${TOP_PWD}/
#CONFIG_NAME=origen
#CONFIG_NAME=vexpress_ca9x4
#CONFIG_NAME=tiny4412
CONFIG_NAME=$UBOOT_BASE_BOARD_NAME

echo "Clean Configuration File..."
#make -C u-boot-${U_BOOT_VERSION} O=${TOP_PWD}/out_${CONFIG_NAME} distclean

echo "Clean Obj..."
#make -C u-boot-${U_BOOT_VERSION} O=${TOP_PWD}/out_${CONFIG_NAME} clean

echo "Load Configuration File..."
echo "will make ${CONFIG_NAME}_defconfig"
#make -C u-boot-${U_BOOT_VERSION} O=${TOP_PWD}/out tiny4412_defconfig
make -C u-boot-${U_BOOT_VERSION} O=${TOP_PWD}/out_${CONFIG_NAME} ${CONFIG_NAME}_defconfig

echo "make..."
#make CROSS_COMPILE=arm-linux-
echo "$$PWD:$PWD"
make -C u-boot-${U_BOOT_VERSION} O=${TOP_PWD}/out_${CONFIG_NAME} CROSS_COMPILE=arm-linux-gnueabihf- -j8 2>&1 | tee build_u_boot.log

echo "backup..."
#cp .config ./configs/tiny4412_defconfig
cd $OLDPWD

