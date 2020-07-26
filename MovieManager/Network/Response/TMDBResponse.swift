//
//  TMDBResponse.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/25/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import Foundation

struct TMDBResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension TMDBResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
