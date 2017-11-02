//
//  ObservableType+Int.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/2/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class RxSwift.Observable
import protocol RxSwift.ObservableType
import protocol RxSwift.RxAbstractInteger
import protocol RxSwift.SchedulerType

typealias RxIntegerInterval = Int

extension ObservableType where E: RxAbstractInteger {
    static func interval(_ period: RxIntegerInterval, scheduler: SchedulerType) -> Observable<E> {
        let dueTime = Double(period)

        return interval(dueTime, scheduler: scheduler)
    }
}
