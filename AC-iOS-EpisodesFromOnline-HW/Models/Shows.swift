//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Shows: Codable {
    let show: Show
}

struct Show: Codable {
    let id: Int
    let name: String
    let language: String
    let genres: [String]
    let status: String
    let rating: Rating
    let image: Image?
}

struct Rating: Codable {
    let average: Double?
}

struct Image: Codable {
    let medium: String?
    let original: String?
}

struct Episode: Codable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let image: Image?
    let summary: String?
}
