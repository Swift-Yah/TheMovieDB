//
//  Typealiases.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/2/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

typealias ConfigurationResponse = Result<Configuration, MovieError>
typealias StringResponse = Result<String, MovieError>
typealias DecodableResponse = Result<Decodable, MovieError>
typealias MovieDetailResponse = Result<MovieDetail, MovieError>
typealias MoviePageResponse = Result<Page<Movie>, MovieError>
typealias MoviePageDateResponse = Result<PageDate<Movie>, MovieError>
