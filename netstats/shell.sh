#!/bin/bash
## ==============================================================================================
## 流量统计脚本
## USAGE: bash <(wget --no-check-certificate -qO- 'https://shell.ssss.fun/nstats/shell.sh') eth0
## Website: https://i.ssss.fun
## Powered By YY-ZHENG
## 中國遠徵提供技术支持
## ==============================================================================================

ethn=$1
IP="$(curl -s https://myip.ipip.net -A YUANZHENG)"

while true
do
  RX_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
  TX_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')
  sleep 1
  RX_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
  TX_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')

  clear
  echo " 🟢  $IP"
  echo "[37m===============================================================================[0m"
  echo "[36m  ██████   █████  █████████  ███████████   █████████   ███████████  █████████  [0m"
  echo "[36m ░░██████ ░░███  ███░░░░░███░█░░░███░░░█  ███░░░░░███ ░█░░░███░░░█ ███░░░░░███ [0m"
  echo "[36m  ░███░███ ░███ ░███    ░░░ ░   ░███  ░  ░███    ░███ ░   ░███  ░ ░███    ░░░  [0m"
  echo "[36m  ░███░░███░███ ░░█████████     ░███     ░███████████     ░███    ░░█████████  [0m"
  echo "[36m  ░███ ░░██████  ░░░░░░░░███    ░███     ░███░░░░░███     ░███     ░░░░░░░░███ [0m"
  echo "[36m  ░███  ░░█████  ███    ░███    ░███     ░███    ░███     ░███     ███    ░███ [0m"
  echo "[36m  █████  ░░█████░░█████████     █████    █████   █████    █████   ░░█████████  [0m"
  echo "[36m ░░░░░    ░░░░░  ░░░░░░░░░     ░░░░░    ░░░░░   ░░░░░    ░░░░░     ░░░░░░░░░   [0m"
  echo "[37m===============================================================================[0m"
  echo " 🌐  监测网卡：[34m$ethn[0m"
  echo "[37m===============================================================================[0m"
  echo " 🔼  上传速度：[33m$TX[0m"
  echo " 🔽  下载速度：[32m$RX[0m"
  echo "[37m-------------------------------------------------------------------------------[0m"
  echo " 🔼  上传总量：[33m$TX_all[0m"
  echo " 🔽  下载总量：[32m$RX_all[0m"
  echo "[37m===============================================================================[0m"
  echo "[44m                 Copyright © 1998 中國遠徵 All Rights Reserved                 [0m"
  echo "[37m===============================================================================[0m"
#   echo "TIME: `date +%T`"
  uptime

  RX=$((${RX_next}-${RX_pre}))
  TX=$((${TX_next}-${TX_pre}))

  if [[ $RX -lt 1024 ]];then
    RX="${RX}B/s"
  elif [[ $RX -ge 1048576 ]];then
    RX=$(echo $RX | awk '{print $1/1048576 "MB/s"}')
  else
    RX=$(echo $RX | awk '{print $1/1024 "KB/s"}')
  fi

  if [[ $TX -lt 1024 ]];then
    TX="${TX}B/s"
  elif [[ $TX -ge 1048576 ]];then
    TX=$(echo $TX | awk '{print $1/1048576 "MB/s"}')
  else
    TX=$(echo $TX | awk '{print $1/1024 "KB/s"}')
  fi

  RX_all=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
  TX_all=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')

  if [[ $RX_all -lt 1024 ]];then
    RX_all="${RX_all}B"
  elif [[ $RX_all -ge 1024 ]] && [[ $RX_all -lt 1048576 ]];then
    RX_all=$(echo $RX_all | awk '{print $1/1024 "KB"}')
  elif [[ $RX_all -ge 1048576 ]] && [[ $RX_all -lt 1073741824 ]];then
    RX_all=$(echo $RX_all | awk '{print $1/1048576 "MB"}')
  else
    RX_all=$(echo $RX_all | awk '{print $1/1073741824 "GB"}')
  fi

  if [[ $TX_all -lt 1024 ]];then
    TX_all="${TX_all}B"
  elif [[ $TX_all -ge 1024 ]] && [[ $TX_all -lt 1048576 ]];then
    TX_all=$(echo $TX_all | awk '{print $1/1024 "KB"}')
  elif [[ $TX_all -ge 1048576 ]] && [[ $TX_all -lt 1073741824 ]];then
    TX_all=$(echo $TX_all | awk '{print $1/1048576 "MB"}')
  else
    TX_all=$(echo $TX_all | awk '{print $1/1073741824 "GB"}')
  fi

done
