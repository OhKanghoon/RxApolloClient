# RxApolloClient

[![CI Status](https://img.shields.io/travis/OhKanghoon/RxApolloClient.svg?style=flat)](https://travis-ci.org/OhKanghoon/RxApolloClient)
[![Version](https://img.shields.io/cocoapods/v/RxApolloClient.svg?style=flat)](https://cocoapods.org/pods/RxApolloClient)
[![License](https://img.shields.io/cocoapods/l/RxApolloClient.svg?style=flat)](https://cocoapods.org/pods/RxApolloClient)
[![Platform](https://img.shields.io/cocoapods/p/RxApolloClient.svg?style=flat)](https://cocoapods.org/pods/RxApolloClient)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 10.0
- Swift 4.2

## Installation

RxApolloClient is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxApolloClient'
```

## Usage
### Fetch
```swift
client.rx
  .fetch(query: SearchRepositoriesQuery(query: "test"))
```
### Watch
```swift
client.rx
  .watch(query: SearchRepositoriesQuery(query: "test"))
```
### Mutate
```swift
client.rx
  .perform(mutation: AddStarMutation(id: "test"))
```

## Author

OhKanghoon, ggaa96@naver.com

## License

RxApolloClient is available under the MIT license. See the LICENSE file for more info.
