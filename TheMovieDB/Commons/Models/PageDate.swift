//
//  PageDate.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct PageDate<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    let page: Int
    let results: [T]
    let dates: DateRange
    let totalPages: Int
    let totalResults: Int
}
