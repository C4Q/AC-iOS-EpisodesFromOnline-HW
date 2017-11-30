//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable {
    let url: String?
    let name: String?
    let season: Int?
    let number: Int?
    let image: Image?
    let summary: String?
    let airdate: String?
}
