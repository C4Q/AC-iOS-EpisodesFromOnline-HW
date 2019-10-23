//
//  shows.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by hildy abreu on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct TVMaveModel: Codable {
    let name: String
    let season: Int
    let epiNumber: Int
    let rating: Rating
    let image: ImageContainer
    let embedded: EmbeddedContent
    enum CodingKeys: String, CodingKey {
        case name
        case season
        case epiNumber = "number"
        case rating
        case image
        case embedded = "_embedded"
    }

}
struct Rating: Codable {
    let average: Double
}

struct ImageContainer: Codable {
    let medium: String
}
struct EmbeddedContent: Codable {
    let episodes: [Episode]
}
struct Episode: Codable {
    let name: String
    let airdate: String
    let image: ImageContainer
    let summary: String
}


