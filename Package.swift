// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XC-PromiseKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "XC-PromiseKit",
            targets: ["XC-PromiseKit"]),
    ],
    targets: [
        .target(
            name: "XC-PromiseKit",
            dependencies: ["PromiseKit"],
            exclude: [
                "make-xcframework.sh",
                "release-package.sh"
            ]
        ),
        .binaryTarget(
            name: "PromiseKit",
            path: "Frameworks/PromiseKit.xcframework"
        )
    ]
)
