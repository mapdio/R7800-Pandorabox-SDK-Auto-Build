#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# 移除ACwifidude自带bin目录
rm -rf bin

# 并入 lean插件包feeds和firewall
git clone https://github.com/coolsnowwolf/lede
cp -r lede/package/lean package/
\cp lede/feeds.conf.default feeds.conf.default


# 添加 ssr plus 和passwall 支持源
sed -i '$a src-git kenzok8 https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small  https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git OpenAppFilter https://github.com/OpenWrt-Actions/OpenAppFilter' feeds.conf.default

# URL替换
sed -i s'/pangubox.com/pangubox.com:6380/' scripts/download.pl

# 仅编译R7800固件
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += netgear_r7800|TARGET_DEVICES += netgear_r7800|' target/linux/qualcomm/image/ipq806x.mk

# 添加UPX UCL工具包
# cp -r lede/tools/upx tools
# cp -r lede/tools/ucl tools

# 修改makefile
sed  -i '/^# builddir dependencies/i\tools-y += ucl upx' ./tools/Makefile
sed  -i '/^# builddir dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' ./tools/Makefile


# 删除重复插件
rm -rf package/lean/ipt2socks
rm -rf package/lean/dns2socks
rm -rf package/lean/pdnsd-alt
rm -rf package/lean/shadowsocksr-libev
rm -rf package/lean/simple-obfs
rm -rf package/lean/v2ray-plugin
rm -rf package/lean/v2ray
rm -rf package/lean/microsocks



# 删除lede文件夹
rm -rf lede
