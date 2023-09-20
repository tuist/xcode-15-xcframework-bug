#!/usr/bin/env bash

PROJECT_NAME="Project"
SCHEME_NAME="Project"

rm -rf build/

DEVICE_PATH="$(mktemp -d -t TemporaryDirectory)/device"
SIMULATOR_PATH="$(mktemp -d -t TemporaryDirectory)/simulator"

# Build the framework for iOS devices
xcodebuild archive -project "Project/$PROJECT_NAME.xcodeproj" \
                   -scheme "$SCHEME_NAME" \
                   -destination "generic/platform=iOS" \
                   -archivePath "$DEVICE_PATH" \
                   SKIP_INSTALL=NO \
                   BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build the framework for iOS simulator
xcodebuild archive -project "Project/$PROJECT_NAME.xcodeproj" \
                   -scheme "$SCHEME_NAME" \
                   -destination "generic/platform=iOS Simulator" \
                   -archivePath "$SIMULATOR_PATH" \
                   SKIP_INSTALL=NO \
                   BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
           -framework "$DEVICE_PATH.xcarchive/Products/Library/Frameworks/$SCHEME_NAME.framework" \
           -framework "$SIMULATOR_PATH.xcarchive/Products/Library/Frameworks/$SCHEME_NAME.framework" \
           -output "$SCHEME_NAME.xcframework"

