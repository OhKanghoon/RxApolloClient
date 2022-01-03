//
//  Client.swift
//  RxApolloClient_Example
//
//  Created by Kanghoon on 18/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Apollo
import RxSwift
import RxApolloClient

final class Client {
  private let client: ApolloClient

  init() {
    let configuration: URLSessionConfiguration = .default
    // TODO: Add your token
    configuration.httpAdditionalHeaders = ["Authorization": "Bearer ADDYOURTOKEN"]
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

    let sessionClient = URLSessionClient(
      sessionConfiguration: configuration,
      callbackQueue: .main
    )
    let store = ApolloStore(cache: InMemoryNormalizedCache())

    self.client = ApolloClient(
      networkTransport: RequestChainNetworkTransport(
        interceptorProvider: DefaultInterceptorProvider(
          client: sessionClient,
          shouldInvalidateClientOnDeinit: true,
          store: store
        ),
        endpointURL: URL(string: "https://api.github.com/graphql")!
      ),
      store: store
    )
  }

  func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .default,
    queue: DispatchQueue = DispatchQueue.main
  ) -> Observable<Query.Data> {
    return self.client.rx
      .fetch(query: query,
             cachePolicy: cachePolicy,
             queue: queue)
      .asObservable()
  }
}
