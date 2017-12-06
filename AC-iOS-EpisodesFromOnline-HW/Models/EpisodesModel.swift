//
//  EpisodesModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct EpisodeInfo: Codable {
    let name: String
    let episodeCollection: EmbeddedWrapper
    enum CodingKeys: String, CodingKey {
        case episodeCollection = "_embedded"
        case name
    }
}

struct EmbeddedWrapper: Codable {
    let episodes: [EpisodeWrapper]
}

struct EpisodeWrapper: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: PictureWrapper?
    let summary: String?
}

struct PictureWrapper: Codable {
    let medium: String
    let original: String
}
