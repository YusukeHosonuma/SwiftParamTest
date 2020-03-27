// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftParamTest",
    products: [
        .library(name: "SwiftParamTest", targets: ["SwiftParamTest"]),
    ],
    dependencies: [
        .package(url: "https://github.com/YusukeHosonuma/Flatten.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "SwiftParamTest", dependencies: ["Flatten"], path: "Sources"),
        .testTarget(name: "SwiftParamTestTests", dependencies: ["SwiftParamTest"]),
    ]
)
