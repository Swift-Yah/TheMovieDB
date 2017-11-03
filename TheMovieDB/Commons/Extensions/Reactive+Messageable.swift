//
//  Reactive+Messageable.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/3/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxCocoa.Binder
import struct RxSwift.Reactive

extension Reactive where Base: Messageable {
    var error: Binder<String?> {
        return Binder(base) { (messageable, value) in
            guard let value = value else {
                return messageable.messageGateway.hide()
            }
            
            messageable.messageGateway.error(message: value)
        }
    }
}

