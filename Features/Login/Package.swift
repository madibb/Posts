// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Login",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Login",
            targets: ["Login"]
        ),
    ],
    dependencies: [
        .package(path: "../../Components"),
        .package(path: "../../Features/Posts")
    ],
    targets: [
        .target(
            name: "Login",
            dependencies: [
                "Components",
                "Posts"
            ],
            path: "Sources"
        )
    ]
)
