//
//  HomeEvent.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum HomeEvent {
    case popularSelected
    case topRatedSelected
    case upcomingSelected
    case configSelected
    case detailSelected(id: String)
    case nowPlayingSelected
    case response(StringResponse)
}
