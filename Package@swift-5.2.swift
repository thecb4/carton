// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "carton",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "SwiftToolchain", targets: ["SwiftToolchain"]),
    .library(name: "CartonHelpers", targets: ["CartonHelpers"]),
    .library(name: "CartonKit", targets: ["CartonKit"]),
    .library(name: "CartonCLI", targets: ["CartonCLI"]),
    .executable(name: "carton", targets: ["Carton"]),
    .executable(name: "carton-release", targets: ["carton-release"]),
  ],
  dependencies: [
    .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.1.1"),
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      .upToNextMinor(from: "0.3.0")
    ),
    .package(
      name: "SwiftPM",
      url: "https://github.com/apple/swift-package-manager.git",
      .branch("release/5.4")
    ),
    .package(
      url: "https://github.com/apple/swift-tools-support-core.git",
      .branch("release/5.4")
    ),
    .package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.10.0"),
    .package(url: "https://github.com/vapor/vapor.git", from: "4.29.3"),
    .package(url: "https://github.com/apple/swift-crypto.git", from: "1.1.0"),
    .package(url: "https://github.com/JohnSundell/Splash.git", from: "0.14.0"),
    .package(url: "https://github.com/swiftwasm/WasmTransformer", .upToNextMinor(from: "0.0.1")),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module
    // or a test suite. Targets can depend on other targets in this package, and on
    // products in packages which this package depends on.
    .target(
      name: "Carton",
      dependencies: [
        "CartonCLI",
        // commented out for now. Will remove once confirmed working
//        .product(name: "ArgumentParser", package: "swift-argument-parser"),
//        .product(name: "AsyncHTTPClient", package: "async-http-client"),
//        .product(name: "Crypto", package: "swift-crypto"),
//        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
//        .product(name: "Vapor", package: "vapor"),
//        "CartonHelpers",
//        openCombineProduct,
//        "SwiftToolchain",
      ]
    ),
    .target(
      name: "CartonCLI",
      dependencies: ["CartonKit"]
    ),
    .target(
      name: "CartonKit",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "Crypto", package: "swift-crypto"),
        .product(name: "Vapor", package: "vapor"),
        "CartonHelpers",
        "OpenCombine",
        "SwiftToolchain",
      ]
    ),
    .target(
      name: "SwiftToolchain",
      dependencies: [
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "SwiftPMDataModel", package: "SwiftPM"),
        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
        "CartonHelpers",
        "OpenCombine",
        "WasmTransformer",
      ]
    ),
    .target(
      name: "CartonHelpers",
      dependencies: [
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
        "OpenCombine",
        "Splash",
      ]
    ),
    // This target is used only for release automation tasks and
    // should not be installed by `carton` users.
    .target(
      name: "carton-release",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        "CartonHelpers",
      ]
    ),
    .testTarget(
      name: "CartonTests",
      dependencies: [
        "Carton",
        "CartonHelpers",
        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .testTarget(
      name: "CartonCommandTests",
      dependencies: [
        "CartonCLI",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
      ]
    ),
  ]
)
