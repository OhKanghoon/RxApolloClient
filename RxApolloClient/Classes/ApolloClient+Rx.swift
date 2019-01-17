//
//  ApolloClient+Rx.swift
//  Pods-RxApolloClient_Example
//
//  Created by Kanghoon on 17/01/2019.
//

import Foundation
import Apollo
import RxSwift

enum ApolloError: Error {
    case gqlErrors([GraphQLError])
}

extension ApolloClient: ReactiveCompatible { }

extension Reactive where Base: ApolloClient {
    
    /**
     Fetches a query from the server or from the local cache, depending on the current contents of the cache and the specified cache policy.
     
     - parameter query: The query to fetch.
     - parameter cachePolicy: A cache policy that specifies whether results should be fetched from the server or loaded from the local cache
     - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
     
     - returns: A generic observable of fetched query data
     */
    public func fetch<Query: GraphQLQuery>(query: Query,
                                           cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                           queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
        return Observable.create { observer in
            let cancellable = self.base
                .fetch(query: query,
                       cachePolicy: cachePolicy,
                       queue: queue,
                       resultHandler: { (result, error) in
                        if let error = error {
                            observer.onError(error)
                        } else if let errors = result?.errors {
                            observer.onError(ApolloError.gqlErrors(errors))
                        } else if let data = result?.data {
                            observer.onNext(data)
                            observer.onCompleted()
                        } else {
                            observer.onCompleted()
                        }
                })
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
    
    /**
     Watches a query by first fetching an initial result from the server or from the local cache, depending on the current contents of the cache and the specified cache policy. After the initial fetch, the returned query watcher object will get notified whenever any of the data the query result depends on changes in the local cache, and calls the result handler again with the new result.
     
     - parameter query: The query to watch.
     - parameter cachePolicy: A cache policy that specifies whether results should be fetched from the server or loaded from the local cache
     - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
     
     - returns: A generic observable of watched query data
     */
    public func watch<Query: GraphQLQuery>(query: Query,
                                           cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                           queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
        return Observable.create { observer in
            let cancellable = self.base
                .watch(query: query,
                       cachePolicy: cachePolicy,
                       queue: queue,
                       resultHandler: { (result, error) in
                        if let error = error {
                            observer.onError(error)
                        } else if let errors = result?.errors {
                            observer.onError(ApolloError.gqlErrors(errors))
                        } else if let data = result?.data {
                            observer.onNext(data)
                        }
                })
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
    
    /**
     Performs a mutation by sending it to the server.
     
     - parameter mutation: The query to fetch.
     - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
     
     - returns: A generic observable of created mutation data
     */
    public func perform<Mutation: GraphQLMutation>(mutation: Mutation,
                                                   queue: DispatchQueue = DispatchQueue.main) -> Observable<Mutation.Data> {
        return Observable.create { observer in
            let cancellable = self.base
                .perform(mutation: mutation,
                         queue: queue,
                         resultHandler: { (result, error) in
                            if let error = error {
                                observer.onError(error)
                            } else if let errors = result?.errors {
                                observer.onError(ApolloError.gqlErrors(errors))
                            } else if let data = result?.data {
                                observer.onNext(data)
                                observer.onCompleted()
                            } else {
                                observer.onCompleted()
                            }
                })
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
