//
//  MovieMoyaGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Moya.MoyaProvider
import struct RxSwift.Single

struct MovieMoyaGateway: MoyaGateway, MovieGateway {
    private let movieProvider = MoyaProvider<MovieTarget>()
    
    func getDetail(id: String) -> Single<MovieDetail> {
        let detailEndpoint = MovieTarget.detail(id: id)
        
        return request(detailEndpoint, using: movieProvider)
    }
    
    func getNowPlaying() -> Single<PageDate<Movie>> {
        return request(.nowPlaying, using: movieProvider)
    }
    
    func getPopular() -> Single<Page<Movie>> {
        return request(.popular, using: movieProvider)
    }
    
    func getTopRated() -> Single<Page<Movie>> {
        return request(.topRated, using: movieProvider)
    }
    
    func getUpcoming() -> Single<PageDate<Movie>> {
        return request(.upcoming, using: movieProvider)
    }
}
