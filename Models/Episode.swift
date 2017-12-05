//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct EpisodeInfo: Codable {
    let show: EpWrapper
}
struct EpWrapper: Codable {
    let id: Int?
    let url: String
    let name: String
    let season: Int
    let number: Int
    let image: Image?
    let summary: String?
    
}
struct Image: Codable{
    var medium: String?
    var original: String?
    
}
