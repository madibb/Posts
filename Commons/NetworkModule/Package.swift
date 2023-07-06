// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "NetworkModule",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "NetworkModule",
            targets: ["NetworkModule"]
        ),
    ],
    dependencies: [
        .package(path: "../../Data/Models"),
        .package(path: "../../Commons/Utils")
    ],
    targets: [
        .target(
            name: "NetworkModule",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "NetworkModuleTests",
            dependencies: [
               "NetworkModule",
               "Models",
               "Utils"
            ],
            path: "Tests"
        ),

    ]
)
