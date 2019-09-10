//
//  Episodes.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episodes: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: EpisodeImage?
    let summary: Image
}

struct EpisodeImage: Codable {
    let medium: String
    let original: String
}
