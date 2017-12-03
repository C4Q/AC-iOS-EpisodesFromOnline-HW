//
//  SeasonAndEpisodeModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct EpisodeInfo: Codable {
    let episode: Episode
}

struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    
}
