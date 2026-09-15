#!/usr/bin/env bash

set -u

failures=0

pass() {
  printf '[PASS] %s\n' "$1"
}

warn() {
  printf '[WARN] %s\n' "$1"
}

fail() {
  printf '[FAIL] %s\n' "$1"
  failures=$((failures + 1))
}

if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  source /etc/os-release
  if [[ "${ID:-}" == "ubuntu" && "${VERSION_ID:-}" == "22.04" ]]; then
    pass "Ubuntu ${VERSION_ID}"
  else
    fail "Expected Ubuntu 22.04, found ${PRETTY_NAME:-unknown system}"
  fi
else
  fail "Cannot read /etc/os-release"
fi

if [[ "${ROS_DISTRO:-}" == "humble" ]]; then
  pass "ROS_DISTRO=humble"
elif [[ -z "${ROS_DISTRO:-}" ]]; then
  fail "ROS_DISTRO is unset; run: source /opt/ros/humble/setup.bash"
else
  fail "Expected ROS_DISTRO=humble, found ROS_DISTRO=${ROS_DISTRO}"
fi

check_command() {
  local command_name="$1"
  local hint="$2"

  if command -v "$command_name" >/dev/null 2>&1; then
    pass "$command_name"
  else
    fail "$command_name not found; $hint"
  fi
}

check_command ros2 "install ROS 2 Humble and source its setup.bash"
check_command colcon "install python3-colcon-common-extensions"
check_command git "install Git"
check_command cmake "install CMake"
check_command python3 "install Python 3"

architecture="$(uname -m 2>/dev/null || printf 'unknown')"
if [[ "$architecture" == "x86_64" ]]; then
  pass "architecture=x86_64"
else
  warn "architecture=${architecture}; the bundled Livox SDK library is x86-64"
fi

if [[ -e /usr/local/lib/liblivox_lidar_sdk_shared.so ]]; then
  pass "Livox-SDK2 library"
else
  warn "Livox-SDK2 library not found in /usr/local/lib; Tasks 2-3 may not build"
fi

if ((failures == 0)); then
  printf '[PASS] Environment check completed\n'
  exit 0
fi

printf '[FAIL] Environment check completed with %d failure(s)\n' "$failures"
exit 1
