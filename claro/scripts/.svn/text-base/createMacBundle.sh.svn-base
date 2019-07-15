#!/bin/sh

BUNDLE=$1
EXECUTABLE=$2

rm -rf $BUNDLE.app
mkdir $BUNDLE.app
mkdir $BUNDLE.app/Contents

echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>CFBundleDevelopmentRegion</key>
        <string>English</string>
        <key>CFBundleExecutable</key>
        <string>$BUNDLE</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleSignature</key>
        <string>????</string>
        <key>CFBundleVersion</key>
        <string>0.1</string>
        <key>CFBundleIconFile</key>
        <string>$BUNDLE.icns</string>
        <key>CSResourcesFileMapped</key>
        <true/>
</dict>
</plist>
" > $BUNDLE.app/Contents/Info.plist

mkdir $BUNDLE.app/Contents/MacOS
mkdir $BUNDLE.app/Contents/Resources
mkdir $BUNDLE.app/Contents/Framework

cp $EXECUTABLE $BUNDLE.app/Contents/MacOS/$BUNDLE
install_name_tool -change libclarogt.so.1.0.1.dylib \
@executable_path/../Framework/libclarogt.so.1.0.1.dylib \
$BUNDLE.app/Contents/MacOS/$BUNDLE
cp libclarogt.so.1.0.1.dylib $BUNDLE.app/Contents/Framework/
