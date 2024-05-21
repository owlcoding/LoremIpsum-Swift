// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoremIpsumStatsUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LoremIpsumStatsUI",
            targets: ["LoremIpsumStatsUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/owlcoding/LoremIpsum-Swift", .upToNextMajor(from: "0.6.0"))
//        ,
//        .package(path: "..")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LoremIpsumStatsUI",
            dependencies: [.product(name: "LoremIpsum", package: "LoremIpsum-Swift")]
        ),
        .testTarget(
            name: "LoremIpsumStatsUITests",
            dependencies: ["LoremIpsumStatsUI"]),
    ]
)
