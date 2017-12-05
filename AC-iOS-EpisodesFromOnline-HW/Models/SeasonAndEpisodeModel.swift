//
//  SeasonAndEpisodeModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: ImageWrapper?
    let summary: String?
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}
