//
//  MovieTarget.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import enum Moya.Method

enum MovieTarget: BaseTarget {
    case detail(id: String)
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var method: Method {
        return .get
    }
    
    var path: String {
        switch self {
        case let .detail(id): return "/movie/" + id
        case .nowPlaying: return "/movie/now_playing"
        case .popular: return "/movie/popular"
        case .topRated: return "/movie/top_rated"
        case .upcoming: return "/movie/upcoming"
        }
    }
}
