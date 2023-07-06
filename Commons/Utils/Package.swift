// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]
        )
    ],
    targets: [
        .target(
            name: "Utils",
            path: "Sources"
        )
    ]
)
