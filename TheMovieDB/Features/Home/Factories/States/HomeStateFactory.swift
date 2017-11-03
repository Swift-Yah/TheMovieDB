//
//  HomeStateFactory.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct HomeStateFactory {
    private init() { }
    
    static func make(movieGateway: MovieGateway, configurationGateway: ConfigurationGateway) -> HomeState {
        return HomeState(movieGateway: movieGateway, configurationGateway: configurationGateway)
    }
}
