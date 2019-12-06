//
//  ApolloClient+Rx.swift
//  Pods-RxApolloClient_Example
//
//  Created by Kanghoon on 17/01/2019.
//

import Foundation
import Apollo
import RxSwift

public enum ApolloError: Error {
  case gqlErrors([GraphQLError])
}

extension ApolloClient: ReactiveCompatible { }

extension Reactive where Base: ApolloClient {

  /**
   Fetches a query from the server or from the local cache, depending on the current contents of the cache and the specified cache policy.

   - parameter query: The query to fetch.
   - parameter cachePolicy: A cache policy that specifies whether results should be fetched from the server or loaded from the local cache
   - parameter context: [optional] A context to use for the cache to work with results. Should default to nil.
   - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.

   - returns: A generic observable of fetched query data
   */
  public func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = DispatchQueue.main
  ) -> Maybe<Query.Data> {
    return Maybe.create { [weak base] observer in
      let cancellable = base?.fetch(
        query: query,
        cachePolicy: cachePolicy,
        context: context,
        queue: queue,
        resultHandler: { result in
          switch result {
          case let .success(gqlResult):
            if let errors = gqlResult.errors {
              observer(.error(ApolloError.gqlErrors(errors)))
            } else if let data = gqlResult.data {
              observer(.success(data))
            } else {
              observer(.completed)
            }

          case let .failure(error):
            observer(.error(error))
          }
        }
      )
      return Disposables.create {
        cancellable?.cancel()
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
  public func watch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
    queue: DispatchQueue = DispatchQueue.main
  ) -> Observable<Query.Data> {
    return Observable.create { [weak base] observer in
      let watcher = base?.watch(
        query: query,
        cachePolicy: cachePolicy,
        queue: queue,
        resultHandler: { result in
          switch result {
          case let .success(gqlResult):
            if let errors = gqlResult.errors {
              observer.onError(ApolloError.gqlErrors(errors))
            } else if let data = gqlResult.data {
              observer.onNext(data)
            }

          case let .failure(error):
            observer.onError(error)
          }
        }
      )
      return Disposables.create {
        watcher?.cancel()
      }
    }
  }

  /**
   Performs a mutation by sending it to the server.

   - parameter mutation: The query to fetch.
   - parameter context: [optional] A context to use for the cache to work with results. Should default to nil.
   - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.

   - returns: A generic observable of created mutation data
   */
  public func perform<Mutation: GraphQLMutation>(
    mutation: Mutation,
    context: UnsafeMutableRawPointer? = nil,
    queue: DispatchQueue = DispatchQueue.main
  ) -> Maybe<Mutation.Data> {
    return Maybe.create { [weak base] observer in
      let cancellable = base?.perform(
        mutation: mutation,
        context: context,
        queue: queue,
        resultHandler: { result in
          switch result {
          case let .success(gqlResult):
            if let errors = gqlResult.errors {
              observer(.error(ApolloError.gqlErrors(errors)))
            } else if let data = gqlResult.data {
              observer(.success(data))
            } else {
              observer(.completed)
            }

          case let .failure(error):
            observer(.error(error))
          }
        }
      )
      return Disposables.create {
        cancellable?.cancel()
      }
    }
  }

  /**
   Uploads the given files with the given operation.

   - parameter operation: The operation to send
   - parameter context: [optional] A context to use for the cache to work with results. Should default to nil.
   - parameter files: An array of `GraphQLFile` objects to send.
   - parameter context: [optional] A context to use for the cache to work with results. Should default to nil.
   - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.

   - returns: A generic observable of created operation data
   */
  public func upload<Operation: GraphQLOperation>(
    operation: Operation,
    context: UnsafeMutableRawPointer? = nil,
    files: [GraphQLFile],
    queue: DispatchQueue = .main
  ) -> Maybe<Operation.Data> {
    return Maybe.create { [weak base] observer in
      let cancellable = base?.upload(
        operation: operation,
        context: context,
        files: files,
        queue: queue,
        resultHandler: { result in
          switch result {
          case let .success(gqlResult):
            if let errors = gqlResult.errors {
              observer(.error(ApolloError.gqlErrors(errors)))
            } else if let data = gqlResult.data {
              observer(.success(data))
            } else {
              observer(.completed)
            }
          case let .failure(error):
            observer(.error(error))
          }
        }
      )
      return Disposables.create {
        cancellable?.cancel()
      }
    }
  }

  /**
   Subscribe to a subscription

   - parameter subscription: The subscription to subscribe to.
   - parameter fetchHTTPMethod: The HTTP Method to be used.
   - parameter queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.

   - returns: A generic observable of subscribed Subscription.Data
   */
  public func subscribe<Subscription: GraphQLSubscription>(
    subscription: Subscription,
    queue: DispatchQueue = .main
  ) -> Observable<Subscription.Data> {
    return Observable.create { [weak base] observer in
      let cancellable = base?.subscribe(
        subscription: subscription,
        queue: queue,
        resultHandler: { result in
          switch result {
          case let .success(gqlResult):
            if let errors = gqlResult.errors {
              observer.onError(ApolloError.gqlErrors(errors))
            } else if let data = gqlResult.data {
              observer.onNext(data)
            }

          case let .failure(error):
            observer.onError(error)
          }
        }
      )
      return Disposables.create {
        cancellable?.cancel()
      }
    }
  }
}
