//
//  MovieGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

protocol MovieGateway {
    func getDetail(id: String) -> Single<StringResponse>
    func getNowPlaying() -> Single<StringResponse>
    func getPopular() -> Single<StringResponse>
    func getTopRated() -> Single<StringResponse>
    func getUpcoming() -> Single<StringResponse>
}
