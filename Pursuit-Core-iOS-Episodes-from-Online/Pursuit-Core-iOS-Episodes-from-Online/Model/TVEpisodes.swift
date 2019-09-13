//
//  TVEpisodes.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/6/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: ImageWrapper? 
    let summary: String?
}

