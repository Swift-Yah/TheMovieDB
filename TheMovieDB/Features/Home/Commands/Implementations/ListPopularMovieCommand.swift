//
//  ListPopularMovieCommand.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

struct ListPopularMovieCommand: HomeCommand {
    private let movieGateway: MovieGateway
    
    init(movieGateway: MovieGateway) {
        self.movieGateway = movieGateway
    }
    
    func execute() -> Single<StringResponse> {
        return movieGateway.getPopular()
    }
}
