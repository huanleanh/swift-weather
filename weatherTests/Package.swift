// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "weatherTests",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "weatherTests",
            targets: ["weatherTests"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "weatherTests"),
        .testTarget(
            name: "weatherTestsTests",
            dependencies: ["weatherTests"]),
    ]
)
