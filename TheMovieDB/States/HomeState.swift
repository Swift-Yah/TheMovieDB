//
//  HomeState.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct HomeState {
    var command: HomeCommand?
    var endpoint: BaseTarget?
    var error: Error?
    var result: String
    
    private let movieGateway: MovieGateway
    private let configurationGateway: ConfigurationGateway
    
    // MARK: Initializers
    
    init(command: HomeCommand? = nil, endpoint: BaseTarget? = nil, error: Error? = nil, result: String = "",
         movieGateway: MovieGateway, configurationGateway: ConfigurationGateway) {
        self.command = command
        self.endpoint = endpoint
        self.error = error
        self.result = result
        self.movieGateway = movieGateway
        self.configurationGateway = configurationGateway
    }

    // MARK: Functions

    static func reduce(state: HomeState, event: HomeEvent) -> HomeState {
        var newState = state
        newState.error = nil
        newState.result = ""
        newState.endpoint = nil
        newState.command = nil

        switch event {
        case .popularSelected:
            newState.endpoint = MovieTarget.popular
            newState.command = ListPopularMovieCommand(movieGateway: state.movieGateway)
            
        case .topRatedSelected:
            newState.endpoint = MovieTarget.topRated
            
        case .upcomingSelected:
            newState.endpoint = MovieTarget.upcoming
            
        case .configSelected:
            newState.endpoint = ConfigurationTarget.configuration
            
        case .detailSelected(let id):
            newState.endpoint = MovieTarget.detail(id: id)
            
        case .nowPlayingSelected:
            newState.endpoint = MovieTarget.nowPlaying
            
        case .response(.success(let result)):
            newState.result = result
            
        case .response(.failure(let error)):
            newState.error = error
            
        }

        return newState
    }
}
