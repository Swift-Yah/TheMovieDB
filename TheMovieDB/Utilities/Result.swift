//
//  Result.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
