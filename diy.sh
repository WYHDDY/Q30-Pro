#!/bin/bash

# 移除 SNAPSHOT
sed -i 's,-SNAPSHOT,,g' include/version.mk
sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in
# IP 地址和主机名
sed -i -e 's/192.168.6.1/10.0.0.251/g' -e 's/ImmortalWrt/EnWrt/g' package/base-files/files/bin/config_generate
# LuCI 主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
# CPU 频率显示修正
sed -i '25s/cpu_freq=".*"/cpu_freq="$(mhz | awk -F '\''cpu_MHz='\'' '\''{printf("%.fMHz",$2)}'\'')";/' package/emortal/autocore/files/generic/cpuinfo

# PATCH
patch -p1 < "$GITHUB_WORKSPACE/PATCH/UBI.patch"
cp -rf "$GITHUB_WORKSPACE/PATCH/6.7_Boost_For_Single_TCP_Flow/"* ./target/linux/generic/backport-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/6.7_FQ_packet_scheduling/"* ./target/linux/generic/backport-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/bbr3/"* ./target/linux/generic/backport-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/6.8_Boost_TCP_Performance_For_Many_Concurrent_Connections-bp_but_put_in_hack/"* ./target/linux/generic/hack-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/6.8_Better_data_locality_in_networking_fast_paths-bp_but_put_in_hack/"* ./target/linux/generic/hack-6.6/
