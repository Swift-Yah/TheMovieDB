//
//  HomeState.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct HomeState {
    var endpoint: BaseTarget?
    var error: Error?
    var result: String

    // MARK: Computed variables

    static var empty: HomeState {
        return HomeState(endpoint: nil, error: nil, result: "")
    }

    // MARK: Functions

    static func reduce(state: HomeState, event: HomeEvent) -> HomeState {
        var newState = state
        newState.error = nil
        newState.result = ""
        newState.endpoint = nil

        switch event {
        case .popularSelected: newState.endpoint = MovieTarget.popular
        case .topRatedSelected: newState.endpoint = MovieTarget.topRated
        case .upcomingSelected: newState.endpoint = MovieTarget.upcoming
        case .configSelected: newState.endpoint = ConfigurationTarget.configuration
        case .detailSelected: newState.endpoint = MovieTarget.detail(id: "211672")
        case .nowPlayingSelected: newState.endpoint = MovieTarget.nowPlaying
        case .response(.success(let result)): newState.result = result
        case .response(.failure(let error)): newState.error = error
        }

        return newState
    }
}
