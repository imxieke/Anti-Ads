#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2023-04-05 09:56:00
 # @LastEditTime: 2023-04-05 15:00:23
 # @LastEditors: Cloudflying
 # @Description: Build, Filter and Merge hosts file
### 

ROOT_PATH=$(dirname $(dirname $(realpath $0)))
HOSTS_PATH=${ROOT_PATH}/storage/hosts
DATE=$(date "+%Y-%m-%d")

normal_format=(
	1024-${DATE}.txt
	ad-wars-${DATE}.txt
	adaway-${DATE}.txt
	hostsfile-${DATE}.txt
	miner-${DATE}.txt
	samsang-${DATE}.txt
	spotify-${DATE}.txt
	xiaomi-${DATE}.txt
	yoyo-${DATE}.txt
	youlist-${DATE}.txt
	goodbeyads-${DATE}.txt
	newhosts-${DATE}.txt
	sysctl-${DATE}.txt
	tekintian-mobile-${DATE}.txt
	tekintian-pc-${DATE}.txt
	# youtube-${DATE}.txt # 用途待查
	unified-${DATE}.txt
	unified-fakenews-${DATE}.txt
	winhelp2002-${DATE}.txt
	yhosts-${DATE}.txt
	damengzhu-${DATE}.txt
)

normal_format_miner=(
	miner-${DATE}.txt
)

# Porn Site Block Hosts, Not Ad Block
normal_format_porn=(
	unified-porn-${DATE}.txt
)
normal_format_social=(
	unified-social-${DATE}.txt
)

# adblock_format=(
# 	hblock-${DATE}.txt
# 	neodevhost-${DATE}.txt
# 	hosts-blocklists-${DATE}.txt
# )

# echo ${normal_format[*]}

cd ${HOSTS_PATH}

hosts_rules="#|^@|::|getlantern|_"
porn_rules="0.0.0.0 0.0.0.0|#|^@|::|getlantern|_"

# Filter And Storage
# cat ${normal_format[*]} | grep -E -v "${hosts_rules}" | sort | uniq > ${ROOT_PATH}/dists/hosts.txt
# cat ${normal_format_miner[*]} | grep -E -v "#|^@|::|getlantern|_" | sort | uniq > ${ROOT_PATH}/dists/hosts-miner.txt
# cat ${normal_format_porn[*]} | grep -E -v "${porn_rules}" | sort | uniq > ${ROOT_PATH}/dists/hosts-porn.txt
# cat ${normal_format_social[*]} | grep -E -v "#|^@|::|getlantern|_" | sort | uniq > ${ROOT_PATH}/dists/hosts-social.txt
# cat ${adblock_format[*]} | grep -E -v "!|#" | sort | uniq > ${ROOT_PATH}/dists/hosts-adblock.txt