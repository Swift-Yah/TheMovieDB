//
//  PrimitiveSequence+Result.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Foundation.JSONDecoder
import struct RxSwift.PrimitiveSequence
import struct RxSwift.Single
import enum RxSwift.SingleTrait
import class Moya.Response
import enum Moya.MoyaError

extension PrimitiveSequence where Element == Response, Trait == SingleTrait {
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder()) -> Single<Result<D, MovieError>> {
        return flatMap({ response -> Single<Result<D, MovieError>> in
            let result = try PrimitiveSequence.mapResult(response: response) { response in
                try response.map(type, atKeyPath: keyPath, using: decoder)
            }
            
            return Single.just(result)
        })
    }
    
    func mapString(atKeyPath keyPath: String? = nil) -> Single<Result<String, MovieError>> {
        return flatMap({ response -> Single<Result<String, MovieError>> in
            let result = try PrimitiveSequence.mapResult(response: response) { response in
                try response.mapString(atKeyPath: keyPath)
            }
            
            return Single.just(result)
        })
    }
    
    private static func mapResult<T>(response: Response, mapper: @escaping (Response) throws -> T) throws -> Result<T, MovieError> {
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
