//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct ShowWrapper: Codable {
    let show: Show
}

struct Show: Codable {
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

