//
//  TVShow.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/6/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Result: Codable {
    let show: Show
}
struct Show: Codable {
    let id: Int
    let url: String
    let name: String
    let rating: RatingWrapper?
    let image: ImageWrapper?
}

struct RatingWrapper: Codable {
    let average: Double?
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}
