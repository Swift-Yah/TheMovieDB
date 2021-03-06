//
//  Page.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

class Page<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    let page: Int
    let results: [T]
    let totalResults: Int
    let totalPages: Int
    
    init() {
        page = 0
        results = []
        totalPages = 0
        totalResults = 0
    }
}
