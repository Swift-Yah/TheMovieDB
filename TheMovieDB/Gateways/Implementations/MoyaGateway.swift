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
    func request<T, U: Decodable>(_ token: T, using: MoyaProvider<T>) -> Single<Result<U, MovieServiceError>>
    func requestString<T>(_ token: T, using: MoyaProvider<T>) -> Single<Result<String, MovieServiceError>>
}

extension MoyaGateway {
    func request<T, U: Decodable>(_ token: T, using provider: MoyaProvider<T>) -> Single<Result<U, MovieServiceError>> {
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

    func requestString<T>(_ token: T, using provider: MoyaProvider<T>) -> Single<Result<String, MovieServiceError>> {
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

import class Foundation.JSONDecoder
import struct RxSwift.PrimitiveSequence
import struct RxSwift.Single
import enum RxSwift.SingleTrait
import class Moya.Response
import enum Moya.MoyaError

extension PrimitiveSequence where Element == Response, Trait == SingleTrait {
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder()) -> Single<Result<D, MovieServiceError>> {
        return flatMap({ response -> Single<Result<D, MovieServiceError>> in
            let result = try PrimitiveSequence.mapResult(response: response) { response in
                try response.map(type, atKeyPath: keyPath, using: decoder)
            }

            return Single.just(result)
        })
    }

    func mapString(atKeyPath keyPath: String? = nil) -> Single<Result<String, MovieServiceError>> {
        return flatMap({ response -> Single<Result<String, MovieServiceError>> in
            let result = try PrimitiveSequence.mapResult(response: response) { response in
                try response.mapString(atKeyPath: keyPath)
            }

            return Single.just(result)
        })
    }

    private static func mapResult<T>(response: Response, mapper: @escaping (Response) throws -> T) throws -> Result<T, MovieServiceError> {
        if response.statusCode == 401 {
            return .failure(.apiKeyRequired)
        }

        if response.statusCode == 404 {
            return .failure(.notFound)
        }

        let json: T

        do {
            json = try mapper(response)
        } catch let MoyaError.objectMapping(error, _) {
            return .failure(.objectMapping(error))
        }

        return .success(json)
    }
}
