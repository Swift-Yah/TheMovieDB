//
//  ControlEvent.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import RxCocoa

extension ControlEvent {
    func asSignal() -> Signal<E> {
        return asSignal(onErrorSignalWith: .empty())
    }
}
