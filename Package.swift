// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftParamTest",
    products: [
        .library(name: "SwiftParamTest", targets: ["SwiftParamTest"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftParamTest", dependencies: [], path: "Sources"),
        .testTarget(name: "SwiftParamTestTests", dependencies: ["SwiftParamTest"]),
    ]
)
