// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CoreApp",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CoreApp",
            targets: ["CoreApp"]
        ),
    ],
    dependencies: [
        .package(path: "../../Commons/Dependencies"),
        .package(path: "../../Features/Login"),
        .package(path: "../../Features/Info")
    ],
    targets: [
        .target(
            name: "CoreApp",
            dependencies: [
                "Dependencies",
                "Login",
                "Info"
            ],
            path: "Sources",
            resources: [.process("Resources")]
        )
    ]
)
