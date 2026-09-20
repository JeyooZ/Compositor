#!/bin/bash
# Build a community preview, without Developer ID or Apple notarization.
set -euo pipefail
VERSION=1.0.4-cn.1
APP='Compositor 中文版.app'
mkdir -p dist build/dmg-stage
xcodebuild -project Compositor.xcodeproj -scheme Compositor -configuration Release \
  -destination 'platform=macOS' -derivedDataPath build \
  CODE_SIGN_IDENTITY=- CODE_SIGNING_ALLOWED=YES ONLY_ACTIVE_ARCH=YES build
cp -R build/Build/Products/Release/Compositor.app "build/dmg-stage/$APP"
cp LICENSE build/dmg-stage/LICENSE.txt
ln -s /Applications build/dmg-stage/Applications
codesign --verify --deep --strict "build/dmg-stage/$APP"
file "build/dmg-stage/$APP/Contents/MacOS/Compositor" | tee dist/architecture.txt
# Use AppKit to render the installation window's title and maintainer credit.
swift scripts/dmg-background.swift build/dmg-background.png
mkdir -p build/dmg-stage/.background
cp build/dmg-background.png build/dmg-stage/.background/background.png
hdiutil create -volname 'Compositor 中文版' -srcfolder build/dmg-stage -ov -format UDRW build/community-rw.dmg
mkdir -p build/dmg-mount
hdiutil attach build/community-rw.dmg -mountpoint "$PWD/build/dmg-mount" -noverify
trap 'hdiutil detach "$PWD/build/dmg-mount" || true' EXIT
osascript <<'APPLESCRIPT'
tell application "Finder"
  tell disk "Compositor 中文版"
    open
    set current view of container window to icon view
    set toolbar visible of container window to false
    set statusbar visible of container window to false
    set bounds of container window to {100, 100, 740, 540}
    set options to icon view options of container window
    set arrangement of options to not arranged
    set icon size of options to 96
    set background picture of options to file ".background:background.png"
    set position of item "Compositor 中文版.app" of container window to {160, 220}
    set position of item "Applications" of container window to {480, 220}
    set position of item "LICENSE.txt" of container window to {320, 350}
    update without registering applications
    delay 2
    close
  end tell
end tell
APPLESCRIPT
hdiutil detach "$PWD/build/dmg-mount"
trap - EXIT
hdiutil convert build/community-rw.dmg -format UDZO -o "dist/Compositor-CN-$VERSION-arm64.dmg"
hdiutil verify "dist/Compositor-CN-$VERSION-arm64.dmg"
(cd dist && shasum -a 256 *.dmg > SHA256SUMS.txt)
