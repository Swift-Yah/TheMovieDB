//
//  PrimitiveSequence+Encodable.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Foundation.JSONEncoder
import enum RxSwift.SingleTrait
import struct RxSwift.Single
import struct RxSwift.PrimitiveSequence

//extension PrimitiveSequence where Trait == SingleTrait, Element: Encodable {
//    func mapString() -> Single<String> {
//        return flatMap({ value -> Single<String> in
//            let data = try JSONEncoder().encode(value)
//            
//            guard let jsonString = String(data: data, encoding: .utf8) else {
//                throw EncodableError.stringMapping(value)
//            }
//            
//            return Single.just(jsonString)
//        })
//    }
//}

