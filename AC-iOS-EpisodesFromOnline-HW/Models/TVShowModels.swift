//
//  Models.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ShowInfo: Codable {
    let score: Double
    let show: Show
}

struct Show: Codable {
    let name: String?
    let rating: Rating?
    let image: Image?
    let summary: String?
    let _links: Links
}

struct Links: Codable {
    let previousepisode: Href
}

struct Href: Codable {
    let href: String
}

struct Image: Codable {
    let medium: String?
    let original: String?
}

struct Rating: Codable {
    let average: Double?
}
