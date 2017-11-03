//
//  ListDetailMovieCommand.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/2/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

struct ListDetailMovieCommmand: HomeCommand {
    private let movieGateway: MovieGateway
    private let movieId: String

    init(movieGateway: MovieGateway, movieId: String) {
        self.movieGateway = movieGateway
        self.movieId = movieId
    }

    func execute() -> Single<StringResponse> {
        return movieGateway.getDetail(id: movieId)
    }
}
