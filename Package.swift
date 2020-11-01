// swift-tools-version:5.3
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
        .package(url: "https://github.com/martinpucik/SWXMLHash", .branch("patch-1"))
    ],
    targets: [
        .target(name: "CTKitSwift", dependencies: ["SWXMLHash"]),
        .testTarget(name: "CTKitSwiftTests", dependencies: ["CTKitSwift"]),
    ],
    swiftLanguageVersions: [.v5]
)
