//
//  MovieGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

protocol MovieGateway {
    func request(target: MovieTarget) -> Single<Response>
}

struct MovieMoyaGateway: MovieGateway {
    private let movieProvider = MoyaProvider<MovieTarget>()

    func request(target: MovieTarget) -> Single<Response> {
        return movieProvider.rx.request(target)
    }
}
