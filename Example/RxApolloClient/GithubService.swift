//
//  GithubService.swift
//  RxApolloClient_Example
//
//  Created by Kanghoon on 18/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

typealias Repository = SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository

protocol GithubServiceType {
    func searchRepositories(request: (String, String?)) -> Single<List<Repository>>
}

class GithubService: GithubServiceType {
    
    func searchRepositories(request: (String, String?)) -> Single<List<Repository>> {
        let query = request.0
        let after = request.1
        return Client.shared
            .fetch(query: SearchRepositoriesQuery(query: query,
                                                  first: 20,
                                                  after: after))
            .map { List<Repository>(query: query,
                                    items: $0.search.edges?.compactMap { $0?.node?.asRepository } ?? [],
                                    after: $0.search.pageInfo.endCursor) }

            .asSingle()
    }
}
