//
//  Episodes.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episodes {
    let name: String
    let season: Int
    let number: Int
    let image: ImageWrapper2?
    let summary: String?
}

struct ImageWrapper2: Codable {
    let original: String
}
