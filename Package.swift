// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RxApolloClient",
    platforms: [
      .macOS(.v10_11), .iOS(.v8), .tvOS(.v9), .watchOS(.v3)
    ],
    products: [
        .library(name: "RxApolloClient", targets: ["RxApolloClient"])
    ],
    dependencies: [
      .package(url: "https://github.com/apollographql/apollo-ios.git", from: "0.15.3"),
      .package(url: "git@github.com:ReactiveX/RxSwift.git", from: "5.0.0")
    ],
    targets: [
        .target(name: "RxApolloClient", path: "RxApolloClient/Classes")
    ],
    swiftLanguageVersions: [.v5]
)
