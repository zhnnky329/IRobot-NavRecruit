#!/usr/bin/env bash

set -u

failures=0

pass() {
  printf '[通过] %s\n' "$1"
}

warn() {
  printf '[警告] %s\n' "$1"
}

fail() {
  printf '[失败] %s\n' "$1"
  failures=$((failures + 1))
}

if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  source /etc/os-release
  if [[ "${ID:-}" == "ubuntu" && "${VERSION_ID:-}" == "22.04" ]]; then
    pass "操作系统为 Ubuntu ${VERSION_ID}"
  else
    fail "要求使用 Ubuntu 22.04，当前系统为 ${PRETTY_NAME:-未知系统}"
  fi
else
  fail "无法读取 /etc/os-release"
fi

if [[ "${ROS_DISTRO:-}" == "humble" ]]; then
  pass "ROS 2 发行版为 Humble"
elif [[ -z "${ROS_DISTRO:-}" ]]; then
  fail "未设置 ROS_DISTRO，请先执行：source /opt/ros/humble/setup.bash"
else
  fail "要求使用 ROS 2 Humble，当前 ROS_DISTRO=${ROS_DISTRO}"
fi

check_command() {
  local command_name="$1"
  local hint="$2"

  if command -v "$command_name" >/dev/null 2>&1; then
    pass "已找到命令：$command_name"
  else
    fail "未找到命令：$command_name；$hint"
  fi
}

check_command ros2 "请安装 ROS 2 Humble 并加载其 setup.bash"
check_command colcon "请安装 python3-colcon-common-extensions"
check_command git "请安装 Git"
check_command cmake "请安装 CMake"
check_command python3 "请安装 Python 3"

architecture="$(uname -m 2>/dev/null || printf '未知')"
if [[ "$architecture" == "x86_64" ]]; then
  pass "系统架构为 x86_64"
else
  warn "当前系统架构为 ${architecture}，仓库附带的 Livox SDK 动态库仅适用于 x86-64"
fi

if [[ -e /usr/local/lib/liblivox_lidar_sdk_shared.so ]]; then
  pass "已找到 Livox-SDK2 动态库"
else
  warn "未在 /usr/local/lib 中找到 Livox-SDK2 动态库，相关驱动可能无法构建"
fi

if ((failures == 0)); then
  printf '[通过] 环境检查完成\n'
  exit 0
fi

printf '[失败] 环境检查完成，共发现 %d 个失败项\n' "$failures"
exit 1
