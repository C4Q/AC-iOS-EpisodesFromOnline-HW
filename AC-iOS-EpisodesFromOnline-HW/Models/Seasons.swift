//
//  Seasons.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let embedded: [Episodes]
    // season and episod number
}

//struct Image: Codable {
//    let medium: String
//    let original: String
//}

struct Episodes: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: Image
}

struct Image: Codable {
    let medium: String
    let original: String
}


// http://api.tvmaze.com/shows/1/episodes
