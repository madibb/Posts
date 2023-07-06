// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Info",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Info",
            targets: ["Info"]
        ),
    ],
    dependencies: [
        .package(path: "../../Components"),
    ],
    targets: [
        .target(
            name: "Info",
            dependencies: [
                "Components"
            ],
            path: "Sources"
        )
    ]
)
