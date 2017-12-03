//
//  TVShowsModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let show: ShowWrapper
  
}

struct ShowWrapper: Codable {
    let id : Double
    let name: String
    let genres: [String]
    let runtime: Double
    let rating: Double
    let network: NetworkWrapper
    let image: ImageWrapper
    let summary: String
}

struct NetworkWrapper: Codable {
    let name: String //hbo
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}

