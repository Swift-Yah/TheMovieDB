//
//  PrimitiveSequence+RetryWhen.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/2/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.PrimitiveSequence
import class RxSwift.MainScheduler
import class RxSwift.Observable

extension PrimitiveSequence {
    func retryWhen(maxAttempts: Int) -> PrimitiveSequence<Trait, Element> {
        return retryWhen({ (errorTrigger: Observable<Error>) in
            errorTrigger.enumerated().flatMap({ (attempt, error) -> Observable<Int> in
                guard attempt < maxAttempts - 1 else { return Observable.error(error) }

                return Observable<Int>.interval(attempt + 1, scheduler: MainScheduler.instance).take(1)
            })
        })
    }
}
