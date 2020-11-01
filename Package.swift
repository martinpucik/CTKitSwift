// swift-tools-version:5.1
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
        .package(url: "https://github.com/drmohundro/swxmlhash", .branch("master"))
    ],
    targets: [
        .target(name: "CTKitSwift", dependencies: ["SWXMLHash"]),
        .testTarget(name: "CTKitSwiftTests", dependencies: ["CTKitSwift"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
