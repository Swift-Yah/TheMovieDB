//
//  Environment.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Foundation.Bundle

struct Environment {
    private static var enviroment: [String: AnyObject] {
        guard let env = Bundle.main.infoDictionary?["EnvironmentSettings"] as? [String: AnyObject] else {
            fatalError("'EnvironmentSettings' not found on Info.plist file.")
        }
    
        return env
    }
    
    // MARK: Private functions
    
    private static func getEnvironment<T>(key: String) -> T {
        guard let baseUrl = enviroment[key] as? T else {
            fatalError("'\(key)' not found on Info.plist file.")
        }
        
        return baseUrl
    }
    
    // MARK: Computed variables
    
    static var baseUrl: String {
        return getEnvironment(key: "BASE_URL")
    }
    
    static var apiKey: String {
        return getEnvironment(key: "API_KEY")
    }
}
