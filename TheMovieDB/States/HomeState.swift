//
//  HomeState.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct HomeState {
    var command: HomeCommand?
    var error: Error?
    var result: String
    
    private let movieGateway: MovieGateway
    private let configurationGateway: ConfigurationGateway
    
    // MARK: Initializers
    
    init(command: HomeCommand? = nil, error: Error? = nil, result: String = "", movieGateway: MovieGateway,
         configurationGateway: ConfigurationGateway) {
        self.command = command
        self.error = error
        self.result = result
        self.movieGateway = movieGateway
        self.configurationGateway = configurationGateway
    }

    // MARK: Functions

    static func reduce(state: HomeState, event: HomeEvent) -> HomeState {
        var newState = state
        newState.command = nil
        newState.error = nil
        newState.result = ""

        switch event {
        case .popularSelected:
            newState.command = ListPopularMovieCommand(movieGateway: state.movieGateway)
            
        case .topRatedSelected:
            newState.command = ListTopRatedMovieCommand(movieGateway: state.movieGateway)
            
        case .upcomingSelected:
            newState.command = ListUpcomingMovieCommand(movieGateway: state.movieGateway)
            
        case .configSelected:
            newState.command = ListConfigurationCommand(configurationGateway: state.configurationGateway)
            
        case .detailSelected(let id):
            newState.command = ListDetailMovieCommmand(movieGateway: state.movieGateway, movieId: id)
            
        case .nowPlayingSelected:
            newState.command = ListNowPlayingCommand(movieGateway: state.movieGateway)
            
        case .response(.success(let result)):
            newState.result = result
            
        case .response(.failure(let error)):
            newState.error = error
        }

        return newState
    }
}
