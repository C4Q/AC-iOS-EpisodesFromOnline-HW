//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct ShowInfo: Codable {
    let name: String
    let _embedded: EpisodesWrapper
}

struct EpisodesWrapper: Codable {
    let episodes: [Episode]
}

struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: EpisodeImageWrapper
}

struct EpisodeImageWrapper: Codable {
    let medium: String?
    let original: String
}
