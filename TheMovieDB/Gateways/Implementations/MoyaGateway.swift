//
//  MoyaGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Moya.MoyaProvider
import RxMoya
import struct RxSwift.Single

protocol MoyaGateway {
    func request<T, U: Decodable>(_ token: T, using: MoyaProvider<T>) -> Single<Result<U, MovieError>>
    func requestString<T>(_ token: T, using: MoyaProvider<T>) -> Single<Result<String, MovieError>>
}

extension MoyaGateway {
    func request<T, U: Decodable>(_ token: T, using provider: MoyaProvider<T>) -> Single<Result<U, MovieError>> {
        return provider.rx.request(token)
            .retry(3)
            .map(U.self)
            .retryWhen(maxAttempts: 4)
    }

    func requestString<T>(_ token: T, using provider: MoyaProvider<T>) -> Single<Result<String, MovieError>> {
        return provider.rx.request(token)
            .retry(3)
            .mapString()
            .retryWhen(maxAttempts: 4)
    }
}
