//
//  MovieServiceable.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

protocol MovieServiceable {
    func request(token: BaseTarget) -> Single<MovieListResponse>
}
