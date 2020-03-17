// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CTKitSwift",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "CTKitSwift", targets: ["CTKitSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/drmohundro/swxmlhash", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(name: "CTKitSwift", dependencies: []),
        .testTarget(name: "CTKitSwiftTests", dependencies: ["CTKitSwift"]),
    ]
)
