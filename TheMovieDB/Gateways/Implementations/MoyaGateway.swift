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

protocol MoyaGateway {
    func request<T, U: Codable>(_ token: T, using: MoyaProvider<T>) -> Single<U>
}

extension MoyaGateway {
    func request<T, U: Codable>(_ token: T, using provider: MoyaProvider<T>) -> Single<U> {
        let maxAttempts = 4

        return provider.rx.request(token)
            .retry(3)
            .map(U.self)
            .retryWhen({ errorTrigger in
                return errorTrigger.enumerated().flatMap({ (attempt, error) -> Observable<Int> in
                    guard attempt < maxAttempts - 1 else { return Observable.error(error) }

                    return Observable<Int>.interval(attempt + 1, scheduler: MainScheduler.instance).take(1)
                })
            })
    }
}
