// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RxApolloClient",
    platforms: [
      .macOS(.v10_14), .iOS(.v12), .tvOS(.v12), .watchOS(.v5)
    ],
    products: [
        .library(name: "RxApolloClient", targets: ["RxApolloClient"])
    ],
    dependencies: [
      .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMajor(from: "0.44.0")),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(name: "RxApolloClient", dependencies: ["Apollo", "RxSwift"])
    ],
    swiftLanguageVersions: [.v5]
)
