#!/bin/bash

# Plant Disease Detector Build Script
# This script builds the Flutter app for both Android and iOS

echo "🌱 Plant Disease Detector Build Script"
echo "======================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate code
echo "🔧 Generating code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Run analysis
echo "🔍 Running code analysis..."
flutter analyze --no-fatal-infos

# Run tests
echo "🧪 Running tests..."
flutter test

# Build for Android
echo "🤖 Building Android APK..."
flutter build apk --release

# Build for iOS (only on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Building iOS IPA..."
    flutter build ios --release
else
    echo "⚠️  iOS build skipped (not on macOS)"
fi

echo ""
echo "✅ Build completed successfully!"
echo ""
echo "📱 Android APK: build/app/outputs/flutter-apk/app-release.apk"
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 iOS build: build/ios/iphoneos/Runner.app"
fi
echo ""
echo "🚀 Ready for deployment!"

