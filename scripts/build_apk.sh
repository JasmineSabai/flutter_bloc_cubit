#!/bin/bash

# Define default values or set empty variables
FLAVOR=""
#BUILD_NAME=""
#BUILD_NUMBER=""
FILE_TYPE="apk" # Default to Android APK => ipa, apk, aab
BUILD_MODE="release" # or debug

# Parse command-line arguments
while getopts "f:t:m:" opt; do
  case $opt in
    f) FLAVOR="$OPTARG" ;;
    t) FILE_TYPE="$OPTARG" ;;
    m) BUILD_MODE="$OPTARG" ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

# Navigate to your Flutter project directory (adjust as needed)
# cd /path/to/your/flutter/project

# Clean and get dependencies
echo "Running flutter clean..."
flutter clean
echo "Getting dependencies..."
flutter pub get

# Construct the build command
BUILD_COMMAND="flutter build $FILE_TYPE --$BUILD_MODE"

# Add flavor if specified
if [ ! -z "$FLAVOR" ]; then
  BUILD_COMMAND="$BUILD_COMMAND --flavor $FLAVOR -t lib/main.dart --dart-define=FLAVOR=$FLAVOR"
fi

# Add version and build number if provided
#if [ ! -z "$BUILD_NAME" ]; then
#  BUILD_COMMAND="$BUILD_COMMAND --build-name=$BUILD_NAME"
#fi
#
#if [ ! -z "$BUILD_NUMBER" ]; then
#  BUILD_COMMAND="$BUILD_COMMAND --build-number=$BUILD_NUMBER"
#fi

# Execute the build command
echo "Executing: $BUILD_COMMAND"
eval $BUILD_COMMAND

# Check if build was successful
if [ $? -eq 0 ]; then
  echo "Build completed successfully!"
  # You can add logic here to move or locate the built artifact
else
  echo "Build failed!"
  exit 1
fi

##!/bin/bash
#
## Default values
#FLAVOR="dev"
#PLATFORM="android"
#BUILD_MODE="release" # or debug
#
## Parse arguments
#while getopts "f:p:m:" opt; do
#  case $opt in
#    f) FLAVOR="$OPTARG" ;;
#    p) PLATFORM="$OPTARG" ;;
#    m) BUILD_MODE="$OPTARG" ;;
#    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
#  esac
#done
#
#echo "Building Flutter app with flavor: $FLAVOR, platform: $PLATFORM, mode: $BUILD_MODE"
#
## Clean previous builds
#flutter clean
#
## Get dependencies
#flutter pub get
#
## Build the app
#if [ "$PLATFORM" == "android" ]; then
#  flutter build apk --"$BUILD_MODE" --flavor "$FLAVOR"
#elif [ "$PLATFORM" == "ios" ]; then
#  flutter build ios --"$BUILD_MODE" --flavor "$FLAVOR" --no-codesign # --no-codesign for development
#else
#  echo "Unsupported platform: $PLATFORM"
#  exit 1
#fi
#
#echo "Build complete."