//
//  MovieResults.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

struct MovieResults: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
