// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-weather",
     targets: [
        .target(
            name: "weather",  
            dependencies: [],
            path: "Sources"),      

        .testTarget(
            name: "Tests", 
            dependencies: ["weather"], 
            path: "Tests")             
    ]

)
