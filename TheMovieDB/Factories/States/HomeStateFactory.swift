//
//  HomeStateFactory.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/1/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct HomeStateFactory {
    private init() { }
    
    static func make() -> HomeState {
        let movieGateway = MovieGatewayFactory.make()
        let configurationGateway = ConfigurationFactoryGateway.make()

        return HomeState(movieGateway: movieGateway, configurationGateway: configurationGateway)
    }
}
