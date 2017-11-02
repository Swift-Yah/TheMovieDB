//
//  MoyaGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Moya.MoyaProvider
import struct RxSwift.Single

protocol MoyaGateway {
    func request<T, U: Codable>(_ token: T, using: MoyaProvider<T>) -> Single<U>
}

extension MoyaGateway {
    func request<T, U: Codable>(_ token: T, using provider: MoyaProvider<T>) -> Single<U> {
        return provider.rx.request(token).map(U.self)
    }
}
