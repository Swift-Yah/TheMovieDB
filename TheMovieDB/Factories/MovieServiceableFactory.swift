//
//  MovieServiceableFactory.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Moya.MoyaProvider

struct MovieServiceableFactory {
    private init() { }

    // MARK: Functions

    static func make() -> MovieServiceable {
        let movieProvider = MoyaProvider<MovieTarget>()
        let configurationProvider = MoyaProvider<ConfigurationTarget>()
        let movieService = MovieService(movieProvider: movieProvider, configurationProvider: configurationProvider)

        return movieService
    }
}
