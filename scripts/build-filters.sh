#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2023-04-05 12:51:13
# @LastEditTime: 2025-01-20 16:59:52
# @LastEditors: Cloudflying
# @Description: Build,Filter And Merge Filter Rules
###

# Github Action Set Asia/Shanghai Timezone
export TZ='Asia/Shanghai'

ROOT_PATH=$(dirname $(dirname $(realpath $0)))
FILTERS_PATH=${ROOT_PATH}/storage/filters
DATE=$(date "+%Y-%m-%d")

UPDATE_DATE=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p ${ROOT_PATH}/dists

# 文件太多了 需要合并 五个就差不多了

filters=(
  advert
  annoyance
  cookie
  features
  fonts
  friendly
  # hosts
  miner
  mobile
  notifications
  privacy
  security
  social
  video
)

cd ${FILTERS_PATH}

for filter in ${filters[*]}; do
  cat ${ROOT_PATH}/filters/header/${filter}.txt >${ROOT_PATH}/dists/${filter}.txt
  sed -i "s#%TIMESTAMP%#${UPDATE_DATE} RPC#g" ${ROOT_PATH}/dists/${filter}.txt

  if [[ -f "${ROOT_PATH}/filters/user/${filter}.txt" ]]; then
    cat "${ROOT_PATH}/filters/user/${filter}.txt" >${FILTERS_PATH}/${filter}/custom.txt
  fi

  if [[ ${filter} == "advert" ]]; then
    cat ${ROOT_PATH}/filters/user/provider/*.txt >>${FILTERS_PATH}/${filter}/custom.txt
  fi

  cat ${FILTERS_PATH}/${filter}/*.txt | grep -E -v '^!|^\[' | sed "s#\n##g" | sed "s#\r##g" | sort --ignore-case --ignore-leading-blanks --uniq | uniq >>${ROOT_PATH}/dists/${filter}.txt
done
