//
//  TheMovieDBTarget.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.Data
import struct Foundation.URL
import protocol Moya.TargetType
import enum Moya.Task
import struct Moya.URLEncoding

protocol BaseTarget: TargetType { }

extension BaseTarget {
    var baseURL: URL {
        guard let url = URL(string: Environment.baseUrl) else {
            fatalError("Please the base url is not available")
        }
        
        return url
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestParameters(parameters: [TargetParameters.apiKey: Environment.apiKey],
                                      encoding: URLEncoding.default)
    }
}
