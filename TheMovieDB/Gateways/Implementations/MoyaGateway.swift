//
//  MoyaGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Moya.MoyaProvider
import class RxSwift.MainScheduler
import class RxSwift.Observable
import struct RxSwift.Single
import RxMoya

protocol MoyaGateway {
    func request<T, U: Decodable>(_ token: T, using: MoyaProvider<T>) -> Single<Result<U, MovieError>>
    func requestString<T>(_ token: T, using: MoyaProvider<T>) -> Single<Result<String, MovieError>>
}

extension MoyaGateway {
    func request<T, U: Decodable>(_ token: T, using provider: MoyaProvider<T>) -> Single<Result<U, MovieError>> {
        let maxAttempts = 4

        return provider.rx.request(token)
            .retry(3)
            .map(U.self)
            .retryWhen({ (errorTrigger: Observable<Error>) in
                return errorTrigger.enumerated().flatMap({ (attempt: Int, error: Error) -> Observable<Int> in
                    guard attempt < maxAttempts - 1 else { return Observable.error(error) }

                    return Observable<Int>.interval(attempt + 1, scheduler: MainScheduler.instance).take(1)
                })
            })
    }

    func requestString<T>(_ token: T, using provider: MoyaProvider<T>) -> Single<Result<String, MovieError>> {
        let maxAttempts = 4

        return provider.rx.request(token)
            .retry(3)
            .mapString()
            .retryWhen({ errorTrigger in
                return errorTrigger.enumerated().flatMap({ (attemp, error) -> Observable<Int> in
                    guard attemp < maxAttempts - 1 else { return Observable.error(error) }

                    return Observable<Int>.interval(attemp + 1, scheduler: MainScheduler.instance).take(1)
                })
            })
    }
}
