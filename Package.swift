// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MatomoPublishPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MatomoPublishPlugin",
            targets: ["MatomoPublishPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/Publish.git", from: "0.9.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "MatomoPublishPlugin",
            dependencies: ["Publish", "SwiftSoup"]),
        .testTarget(
            name: "MatomoPublishPluginTests",
            dependencies: ["MatomoPublishPlugin"]),
    ]
)
