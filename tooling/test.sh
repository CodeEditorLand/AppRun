#!/usr/bin/env bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
PROJECT_SRCS=$(dirname "$SCRIPT_DIR")
TOOLCHAIN_DIR="$PROJECT_SRCS/cmake/"

BUILD_TYPE=$1
if [ -z "$BUILD_TYPE" ]; then
  echo "Missing BUILD_TYPE, please provide one as follows:"
  echo "    ./$(basename "$0") ( Debug | Release )"
  exit 1
fi

## Check Arch
if [ -z "$TARGET_ARCH" ]; then
  echo ""
  echo "Missing TARGET_ARCH environment. Please define it before calling $(basename "$0")"
  echo ""
  exit 1
else
  TOOLCHAIN_PATH="$TOOLCHAIN_DIR/$TARGET_ARCH-toolchain.cmake"
  if [[ ! -f "$TOOLCHAIN_PATH" ]]; then
    echo "Unknown TARGET_ARCH: $TARGET_ARCH"
    exit
  fi
fi

BUILD_DIR=$PROJECT_SRCS/cmake-build-"$BUILD_TYPE"-"$TARGET_ARCH"
ctest --test-dir "$BUILD_DIR" --verbose
