// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Posts",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Posts",
            targets: ["Posts"]
        ),
    ],
    dependencies: [
        .package(path: "../../Data/Models"),
        .package(path: "../../Commons/NetworkModule"),
        .package(path: "../../Commons/Utils"),
        .package(path: "../../Commons/Dependencies"),
        .package(path: "../../Components"),
        .package(url: "https://github.com/ashleymills/Reachability.swift", from: "5.1.0"),
    ],
    targets: [
        .target(
            name: "Posts",
            dependencies: [
                "Models", "NetworkModule", "Utils", "Dependencies", "Components",
                .product(name: "Reachability", package: "Reachability.swift")
            ],
            path: "Sources",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "PostsTests",
            dependencies: [
                "Posts", "Dependencies",
                .product(name: "Reachability", package: "Reachability.swift")
            ],
            path: "Tests"
        )
    ]
)
