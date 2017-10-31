//
//  ConfigurationTarget.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import enum Moya.Method

enum ConfigurationTarget: BaseTarget {
    case configuration

    var path: String {
        return "/configuration"
    }

    var method: Method {
        return .get
    }
}
