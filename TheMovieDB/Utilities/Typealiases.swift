//
//  Typealiases.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/2/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

typealias ConfigurationResponse = Result<Configuration, MovieServiceError>
typealias StringResponse = Result<String, MovieServiceError>
typealias DecodableResponse = Result<Decodable, MovieServiceError>
typealias MovieDetailResponse = Result<MovieDetail, MovieServiceError>
typealias MoviePageResponse = Result<Page<Movie>, MovieServiceError>
typealias MoviePageDateResponse = Result<PageDate<Movie>, MovieServiceError>
