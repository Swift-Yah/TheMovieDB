//
//  ConfigurationGatewayFactory.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct ConfigurationFactoryGateway {
    private init() { }
    
    static func make() -> ConfigurationGateway {
        return ConfigurationMoyaGateway()
    }
}
