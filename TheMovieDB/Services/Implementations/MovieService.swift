//
//  MovieService.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import Moya
import RxMoya
import RxSwift

struct MovieService: MovieServiceable {
    private let movieGateway: MovieGateway
    private let configurationProvider: MoyaProvider<ConfigurationTarget>

    // MARK: Initializers

    init(movieGateway: MovieGateway, configurationProvider: MoyaProvider<ConfigurationTarget>) {
        self.movieGateway = movieGateway
        self.configurationProvider = configurationProvider
    }

    // MARK: Functions

    func request(token: BaseTarget) -> Single<MovieListResponse> {
        var response: Single<Response>? = nil

        if let movieTarget = token as? MovieTarget {
            response = movieGateway.request(target: movieTarget)
        } else if let configurationTarget = token as? ConfigurationTarget {
            response = request(configuration: configurationTarget)
        }

        guard let requiredResponse = response else {
            return error()
        }

        let maxAttemps = 4

        return requiredResponse
            .retry(3)
            .map(MovieService.parse)
            .retryWhen({ (errorTrigger: Observable<Error>) in
                errorTrigger.enumerated().flatMap({ (attempt, error) -> Observable<Int> in
                    if attempt >= maxAttemps - 1 {
                        return Observable.error(error)
                    }

                    let dueTime = Double(attempt + 1)

                    return Observable<Int>.timer(dueTime, scheduler: MainScheduler.instance).take(1)
                })
            })
    }

    // MARK: Private functions

    private func error() -> Single<MovieListResponse> {
        return Single<MovieListResponse>.create(subscribe: { single -> Disposable in
            single(.error(MovieServiceError.injectionMismatch))

            return Disposables.create()
        })
    }

    private func request(configuration: ConfigurationTarget) -> Single<Response> {
        return configurationProvider.rx.request(configuration)
    }

    private static func parse(response: Response) throws -> MovieListResponse {
        if response.statusCode == 401 {
            return .failure(.apiKeyRequired)
        }

        if response.statusCode == 404 {
            return .failure(.notFound)
        }

        let json = try response.mapString()

        return .success(json)
    }
}
