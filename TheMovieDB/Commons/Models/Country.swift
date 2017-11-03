//
//  Country.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct Country: Codable {
    enum CodingKeys: String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }
    
    let iso: String
    let name: String
}
