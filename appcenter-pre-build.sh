#!/usr/bin/env bash

    echo "Setup Android simulator"
    SIMULATOR_IMAGE="system-images;android-28;google_apis;x86"
    SIMULATOR_NAME="Pixel_XL_API_28"

    ANDROID_HOME=~/Library/Android/sdk
    ANDROID_SDK_ROOT=~/Library/Android/sdk
    ANDROID_AVD_HOME=~/.android/avd
    PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

    echo "Accepts all sdk licences"
    yes | sdkmanager --licenses

    echo "Download Simulator Image"
    sdkmanager --install "$SIMULATOR_IMAGE"

    echo "Create Simulator '$SIMULATOR_NAME' with image '$SIMULATOR_IMAGE'"
    echo "no" | avdmanager --verbose create avd --force --name "$SIMULATOR_NAME" --device "pixel" --package "$SIMULATOR_IMAGE" --tag "google_apis" --abi "x86"

    DETOX_CONFIG=android.emu.release


echo "Building the project for Detox tests..."
npx detox build --configuration "$DETOX_CONFIG"

echo "Executing Detox tests..."
npx detox test --configuration "$DETOX_CONFIG" --cleanup
