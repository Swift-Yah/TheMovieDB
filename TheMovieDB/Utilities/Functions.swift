//
//  Functions.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

func weakSelfMethodReference<T: AnyObject>(_ valueForSelf: T, _ unbindedMethod: @escaping (T) -> () -> Void) -> (() -> Void) {
    return { [weak valueForSelf] in
        if let valueForSelf = valueForSelf {
            unbindedMethod(valueForSelf)()
        }
    }
}

func weakSelfMethodReference<T: AnyObject, U: Any>(_ valueForSelf: T, _ unbindedMethod: @escaping (T) -> (U) -> Void) -> ((U) -> Void) {
    return { [weak valueForSelf] (u: U) in
        if let valueForSelf = valueForSelf {
            unbindedMethod(valueForSelf)(u)
        }
    }
}
