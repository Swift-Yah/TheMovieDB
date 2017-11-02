//
//  ConfigurationMoyaGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Moya.MoyaProvider
import struct RxSwift.Single

struct ConfigurationMoyaGateway: MoyaGateway, ConfigurationGateway {
    private let configurationProvider = MoyaProvider<ConfigurationTarget>()
    
    func get() -> Single<StringResponse> {
        return requestString(.configuration, using: configurationProvider)
    }
}
