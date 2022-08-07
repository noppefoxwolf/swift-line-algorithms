// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-line-algorithm",
    products: [
        .library(
            name: "LineAlgorithms",
            targets: ["LineAlgorithms"]
        ),
    ],
    targets: [
        .target(
            name: "LineAlgorithms"
        )
    ]
)
