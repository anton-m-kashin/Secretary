// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Secretary",
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", .exact("0.40200.0"))
    ],
    targets: [
        .target(
            name: "SecretsSwift",
            dependencies: ["SwiftSyntax"]),
        .target(
            name: "Secretary",
            dependencies: ["SecretsSwift"])
    ]
)
