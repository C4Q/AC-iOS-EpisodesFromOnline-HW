//
//  Specific Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct SpecificShow: Codable {
    let name: String
    let rating: SpecificRatingWrapper
    let _embedded: EpisodeWrapper
}
struct SpecificRatingWrapper: Codable {
    let average: Double
}



struct EpisodeWrapper: Codable {
    let episodes: [Episode]
}

struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: EpisodeImageWrapper
}

struct EpisodeImageWrapper: Codable {
    let medium: String
    let original: String 
}




