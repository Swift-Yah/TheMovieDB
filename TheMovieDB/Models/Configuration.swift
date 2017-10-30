//
//  Configuration.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct Configuration: Codable {
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
    
    let images: ImageConfiguration
    let changeKeys: String
}
