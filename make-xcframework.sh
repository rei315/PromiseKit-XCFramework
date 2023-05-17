#!/bin/bash

make_promisekit_xcframework() {
    git clone https://github.com/mxcl/PromiseKit

    cd PromiseKit

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
    -output PromiseKit.xcframework

    mv PromiseKit.xcframework ../XC-PromiseKit/Frameworks

    cd ..
    rm -rf PromiseKit
}

make_promisekit_xcframework
