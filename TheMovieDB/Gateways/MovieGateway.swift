//
//  MovieGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

protocol MovieGateway {
    func getDetail(id: String) -> Single<MovieDetail>
    func getNowPlaying() -> Single<PageDate<Movie>>
    func getPopular() -> Single<Page<Movie>>
    func getTopRated() -> Single<Page<Movie>>
    func getUpcoming() -> Single<PageDate<Movie>>
}
