//
//  SessionResponse.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

struct SessionResponse: Codable {
    let session: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case session
        case sessionId = "session_id"
    }
}
