// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Dependencies",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/ashleymills/Reachability.swift", from: "5.1.0"),
        .package(path: "../Utils"),
        .package(path: "../NetworkModule")
    ],
    targets: [
        .target(
            name: "Dependencies",
            dependencies: [
                "Swinject",
                "Utils",
                "NetworkModule",
                .product(name: "Reachability", package: "Reachability.swift")
            ],
            path: "Sources"
        )
    ]
)
