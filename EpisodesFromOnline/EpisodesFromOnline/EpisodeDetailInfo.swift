//
//  EpisodeDetailInfo.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/14/19.
//

import Foundation

struct EpisodeDetailInfo : Codable {
    let id : Int
    let name: String
    let season: Int
    let image : ImageInfo1?
    let summary: String?
}

struct ImageInfo1: Codable {
    let medium: String?
    let original: String?
}
