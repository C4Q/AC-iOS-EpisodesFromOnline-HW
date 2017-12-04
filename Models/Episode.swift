//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let image: String?
    let summary: String
    static let defaultEpisode = Episode(id: 0, url:" noUrl.com", name: "No name" , season: 0, number: 0, image: "N/A", summary: "N/A")
}

