//
//  ConfigurationGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

protocol ConfigurationGateway {
    func get() -> Single<StringResponse>
}
