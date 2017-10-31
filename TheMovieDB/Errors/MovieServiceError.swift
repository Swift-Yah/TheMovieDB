//
//  MovieServiceError.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum MovieServiceError: Error {
    case apiKeyRequired
    case injectionMismatch
    case notFound
    case offline
}
