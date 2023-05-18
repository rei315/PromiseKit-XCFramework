#!/bin/bash

download_promisekit() {
    VERSION_FILE="VERSION.txt"
    OWNER="mxcl"
    REPO="PromiseKit"

    TAG=$(cat "$VERSION_FILE")

    response=$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/tags/$TAG")
    zip_url=$(echo "$response" | awk -F'"' '/"zipball_url":/ { print $4 }')

    FILE_NAME="PromiseKit.zip"

    curl -LJ "$zip_url" -o "$FILE_NAME"
    unzip "$FILE_NAME"
}

find_promisekit_directory() {
    folder=$(find . -maxdepth 1 -type d -name "mxcl-PromiseKit-*" -print -quit)
    echo $folder
}

make_promisekit_xcframework() {
    local directory=$1
    
    cd $directory
    
    xcodebuild archive \
    -scheme PromiseKit \
    -sdk iphonesimulator \
    -archivePath "build/ios_simulators.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

    xcodebuild archive \
    -scheme PromiseKit \
    -sdk iphoneos \
    -archivePath "build/ios_devices.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO
    
    xcodebuild -create-xcframework \
    -framework build/ios_devices.xcarchive/Products/Library/Frameworks/PromiseKit.framework \
    -framework build/ios_simulators.xcarchive/Products/Library/Frameworks/PromiseKit.framework \
    -output ../PromiseKit.xcframework
}

clear_files() {
    local directory=$1
    cd ..
    rm -rf $directory
    rm -rf PromiseKit.zip
}

download_promisekit
promisekit_directory=$(find_promisekit_directory)
make_promisekit_xcframework $promisekit_directory
clear_files $promisekit_directory
