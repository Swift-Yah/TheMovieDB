//
//  ListConfigurationCommand.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/2/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

struct ListConfigurationCommand: HomeCommand {
    private let configurationGateway: ConfigurationGateway

    init(configurationGateway: ConfigurationGateway) {
        self.configurationGateway = configurationGateway
    }

    func execute() -> Single<String> {
        return configurationGateway.get().mapString()
    }
}
