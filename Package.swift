// swift-tools-version:5.3

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
      .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMajor(from: "0.50.0")),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
          name: "RxApolloClient",
          dependencies: [
            .product(name: "Apollo", package: "apollo-ios"),
            .product(name: "RxSwift", package: "RxSwift"),
          ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
