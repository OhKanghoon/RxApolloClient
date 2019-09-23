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

class Client {
    private let client: ApolloClient
    
    init() {
        let configuration: URLSessionConfiguration = .default
        // TODO: Add your token
        configuration.httpAdditionalHeaders = ["Authorization": "token ~~~~~~~~~~~"]
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        let url = URL(string: "https://api.github.com/graphql")!
        client = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session))
    }
    
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                    queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
        return self.client.rx
            .fetch(query: query,
                   cachePolicy: cachePolicy,
                   queue: queue)
            .asObservable()
    }
}
