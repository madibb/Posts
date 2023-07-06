// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Components",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Components",
            targets: ["Components"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Components",
            dependencies: [],
            path: "Sources"
        )
    ]
)
