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
    func getDetail(id: String) -> Single<MovieDetail>
    func getNowPlaying() -> Single<PageDate<Movie>>
    func getPopular() -> Single<Page<Movie>>
    func getTopRated() -> Single<Page<Movie>>
    func getUpcoming() -> Single<PageDate<Movie>>
}

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
        return request(.topRated, using: movieProvider)
    }
}

protocol ConfigurationGateway {
	func get() -> Single<Configuration>
}

struct ConfigurationMoyaGateway: MoyaGateway, ConfigurationGateway {
    private let configurationProvider = MoyaProvider<ConfigurationTarget>()
    
	func get() -> Single<Configuration> {
        return request(.configuration, using: configurationProvider)
	}
}

protocol MoyaGateway {
	func request<T, U: Codable>(_ token: T, using: MoyaProvider<T>) -> Single<U>
}

extension MoyaGateway {
	func request<T, U: Codable>(_ token: T, using provider: MoyaProvider<T>) -> Single<U> {
    	return provider.rx.request(token).map(U.self)
    }
}
