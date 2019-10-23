//
//  detailModel.swift
//  NewShowEpisodesProject
//
//  Created by hildy abreu on 10/20/19.
//  Copyright © 2019 hildy abreu. All rights reserved.
//

import Foundation

struct EpisodeInfo : Codable {
    let id: Int
    let name: String
    let season: Int
    let epiNumber: Int
    let image: ImageContainer?
    let summary : String?

}
