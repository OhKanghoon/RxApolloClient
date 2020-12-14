// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RxApolloClient",
    platforms: [
      .macOS(.v10_11), .iOS(.v9), .tvOS(.v9), .watchOS(.v3)
    ],
    products: [
        .library(name: "RxApolloClient", targets: ["RxApolloClient"])
    ],
    dependencies: [
      .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMajor(from: "0.36.0")),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "RxApolloClient", dependencies: ["Apollo", "RxSwift"])
    ],
    swiftLanguageVersions: [.v5]
)
