// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CTKitSwift",
    products: [
        .library(name: "CTKitSwift", targets: ["CTKitSwift"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "CTKitSwift", dependencies: []),
        .testTarget(name: "CTKitSwiftTests", dependencies: ["CTKitSwift"]),
    ]
)
