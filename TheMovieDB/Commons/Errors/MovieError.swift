//
//  MovieServiceError.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum MovieError: Error, CustomStringConvertible {
    case apiKeyRequired
    case objectMapping(Error)
    case notFound
    case offline
    
    // MARK: CustomStringConvertible conforms
    
    var description: String {
        switch self {
        case .apiKeyRequired: return "Invalid API key: You must be granted a valid key."
        case .objectMapping: return "Failed to map data to a Decodable object."
        case .notFound: return "The resource you requested could not be found."
        case .offline: return "Ups, no network connectivity."
        }
    }
}
