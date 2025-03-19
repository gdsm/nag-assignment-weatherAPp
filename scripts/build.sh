#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting Xcode project setup..."

# 1️⃣ Check if CocoaPods is installed, and install it if missing
if ! command -v pod &> /dev/null; then
    echo "⚠️ CocoaPods not found. Installing..."
    sudo gem install cocoapods
else
    echo "✅ CocoaPods is already installed."
fi

# 2️⃣ Install dependencies using CocoaPods
echo "📦 Installing dependencies with CocoaPods..."
pod install

# 3️⃣ Find the Xcode workspace file and open it
WORKSPACE_FILE=$(ls | grep ".xcworkspace" | head -n 1)
if [ -z "$WORKSPACE_FILE" ]; then
    echo "❌ No Xcode workspace found! Exiting..."
    exit 1
fi

echo "🛠️ Opening Xcode workspace: $WORKSPACE_FILE"
open "$WORKSPACE_FILE"

# 4️⃣ Boot iOS Simulator
DEVICE_NAME="iPhone 16 Pro Max"
echo "📱 Booting Simulator: $DEVICE_NAME..."
xcrun simctl boot "$DEVICE_NAME" || echo "⚠️ Simulator already running."

# 5️⃣ Build and Install the App
SCHEME_NAME="WeatherApp" # ⚠️ Replace with your actual Xcode scheme name!
APP_BUNDLE_ID="com.yourcompany.yourapp" # ⚠️ Replace with your app's bundle identifier

echo "🔨 Building the app..."
xcodebuild -workspace "$WORKSPACE_FILE" -scheme "$SCHEME_NAME" -configuration Debug -sdk iphonesimulator -derivedDataPath ./DerivedData build

# 6️⃣ Find the compiled `.app` file and install it on the simulator
APP_PATH=$(find ./DerivedData -name "*.app" | head -n 1)

if [ -z "$APP_PATH" ]; then
    echo "❌ Build failed: No .app file found! Exiting..."
    exit 1
fi

echo "📲 Installing app on simulator..."
xcrun simctl install booted "$APP_PATH"

# 7️⃣ Launch the App
echo "🚀 Launching app on simulator..."
xcrun simctl launch booted "$APP_BUNDLE_ID"

echo "✅ Setup complete! App is running on the simulator. 🚀"
