#!/bin/bash


# 移除 SNAPSHOT
sed -i 's,-SNAPSHOT,,g' include/version.mk
sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in
# rpcd
sed -i 's/option timeout 30/option timeout 60/g' package/system/rpcd/files/rpcd.config
sed -i 's#20) \* 1000#60) \* 1000#g' feeds/luci/modules/luci-base/htdocs/luci-static/resources/rpc.js
# IP 地址和主机名
sed -i -e 's/192.168.6.1/10.0.0.251/g' -e 's/ImmortalWrt/EnWrt/g' package/base-files/files/bin/config_generate
# LuCI 主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile
# CPU 频率显示修正
sed -i '25s/cpu_freq=".*"/cpu_freq="$(mhz | awk -F '\''cpu_MHz='\'' '\''{printf("%.fMHz",$2)}'\'')";/' package/emortal/autocore/files/generic/cpuinfo
# 2.4
WIRELESS_2="package/mtk/drivers/wifi-profile/files/mt7981/mt7981.dbdc.b0.dat"
# 5
WIRELESS_5="package/mtk/drivers/wifi-profile/files/mt7981/mt7981.dbdc.b1.dat"
# 修改 2.4
sed -i 's/^SSID1=.*$/SSID1=WYH-WIFI2.4/g' "$WIRELESS_2"
sed -i 's/^WPAPSK1=.*$/WPAPSK1=zz123456/g' "$WIRELESS_2"
sed -i 's/^AuthMode=.*$/AuthMode=WPA2PSKWPA3PSK/g' "$WIRELESS_2"
sed -i 's/^EncrypType=.*$/EncrypType=AES/g' "$WIRELESS_2"
# 修改 5
sed -i 's/^SSID1=.*$/SSID1=WYH-WIFI/g' "$WIRELESS_5"
sed -i 's/^WPAPSK1=.*$/WPAPSK1=zz123456/g' "$WIRELESS_5"
sed -i 's/^AuthMode=.*$/AuthMode=WPA2PSKWPA3PSK/g' "$WIRELESS_5"
sed -i 's/^EncrypType=.*$/EncrypType=AES/g' "$WIRELESS_5"
# PATCH
cp -rf "$GITHUB_WORKSPACE/PATCH/6.7_Boost_For_Single_TCP_Flow/"* ./target/linux/generic/backport-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/6.7_FQ_packet_scheduling/"* ./target/linux/generic/backport-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/bbr3/"* ./target/linux/generic/backport-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/6.8_Boost_TCP_Performance_For_Many_Concurrent_Connections-bp_but_put_in_hack/"* ./target/linux/generic/hack-6.6/
cp -rf "$GITHUB_WORKSPACE/PATCH/6.8_Better_data_locality_in_networking_fast_paths-bp_but_put_in_hack/"* ./target/linux/generic/hack-6.6/
