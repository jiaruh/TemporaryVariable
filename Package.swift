// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TemporaryVariable",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13),
    ],
    products: [
        .library(
            name: "TemporaryVariable",
            targets: ["TemporaryVariable"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.0.0-swift-DEVELOPMENT-SNAPSHOT-2023-07-10-a"
        ),
    ],
    targets: [
        .target(
            name: "TemporaryVariablePlugin",
            dependencies:[
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "TemporaryVariable",
            dependencies: [
                "TemporaryVariablePlugin",
            ]
        ),
        .testTarget(
            name: "TemporaryVariableTests",
            dependencies: [
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "TemporaryVariable",
            ]
        ),
    ]
)
