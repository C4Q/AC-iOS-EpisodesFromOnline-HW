//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable {
    let name: String
    let season: Int?
    let number: Int?
    let image: Image?
    let summary: String?
}



