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
    
    func getDetail(id: String) -> Single<StringResponse> {
        let detailEndpoint = MovieTarget.detail(id: id)
        
        return requestString(detailEndpoint, using: movieProvider)
    }
    
    func getNowPlaying() -> Single<StringResponse> {
        return requestString(.nowPlaying, using: movieProvider)
    }
    
    func getPopular() -> Single<StringResponse> {
        return requestString(.popular, using: movieProvider)
    }
    
    func getTopRated() -> Single<StringResponse> {
        return requestString(.topRated, using: movieProvider)
    }
    
    func getUpcoming() -> Single<StringResponse> {
        return requestString(.upcoming, using: movieProvider)
    }
}
