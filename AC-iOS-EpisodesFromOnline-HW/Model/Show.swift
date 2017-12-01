//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Show: Codable {
    let show: DetailWrapper
}

struct DetailWrapper: Codable {
    let name: String
    let rating: RatingWrapper
    let image: ImageWrapper
}

struct RatingWrapper: Codable {
    let average: Double
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}
