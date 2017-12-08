//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable {
    let name: String?
    let season: Int?
    let number: Int?
    let image: ImageWrapper?
    let summary: String?
    let airdate: String?
}
struct ImageWrapper: Codable {
    let original: String
}

