# RxApolloClient

![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![Build Status](https://github.com/OhKanghoon/RxApolloClient/workflows/CI/badge.svg)](https://github.com/OhKanghoon/RxApolloClient/actions)
[![Version](https://img.shields.io/cocoapods/v/RxApolloClient.svg?style=flat)](https://cocoapods.org/pods/RxApolloClient)
[![License](https://img.shields.io/cocoapods/l/RxApolloClient.svg?style=flat)](https://cocoapods.org/pods/RxApolloClient)
[![Platform](https://img.shields.io/cocoapods/p/RxApolloClient.svg?style=flat)](https://cocoapods.org/pods/RxApolloClient)

## Get Started
1. Install Apollo
```sh
$ npm install -g apollo 2.21.0
```
2. Fetch Scheme & Generate API Code
#### get_gql.sh
```sh
cd ____ # project folder
apollo schema:download --endpoint=__________ ./schema.json # end point url / scheme.json location
apollo codegen:generate --target=swift --includes="$(find . -name '*.graphql')" --localSchemaFile=_______/schema.json _______/GraphQLAPI.swift # scheme.json location / generated API code location
```
```sh
$ sh get_gql.sh
```

## Dependencies
- [RxSwift](https://github.com/ReactiveX/RxSwift) (~> 5.1)
- [apollo-ios](https://github.com/apollographql/apollo-ios) (~> 0.36.0)

## Requirements

- Xcode 11.0
- Swift 5.1

## Installation

- Using [CocoaPods](https://cocoapods.org)
```ruby
pod 'RxApolloClient', '1.3.0'
```
- Using [Swift Package Manager]
```swift
import PackageDescription

let package = Package(
  name: "YourApp",
  dependencies: [
    .package(url: "https://github.com/OhKanghoon/RxApolloClient", from: "1.3.0")
  ]
)
```

## Usage
#### Fetch
```swift
client.rx
  .fetch(query:)
```
#### Watch
```swift
client.rx
  .watch(query:)
```
#### Mutate
```swift
client.rx
  .perform(mutation:)
```

#### Upload
```swift
client.rx
  .upload(operation:, files:)
```

### Subscribe
```swift
client.rx
  .subscribe(subscription:)
```

## Example

- [Github Search](https://github.com/OhKanghoon/RxApolloClient/tree/master/Example)

## Author

OhKanghoon, ggaa96@naver.com

## License

RxApolloClient is available under the MIT license. See the LICENSE file for more info.
