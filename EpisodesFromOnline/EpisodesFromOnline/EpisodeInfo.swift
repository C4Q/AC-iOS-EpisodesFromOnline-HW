//
//  EpisodeInfo.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/13/19.
//

import Foundation

struct EpisodeInfo : Codable {
    let id: Int
    let name: String
    let season: Int
    let image: ImageInfo?
    let summary : String?

}


