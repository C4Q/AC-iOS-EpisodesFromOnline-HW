//
//  Shows.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowWrapper: Codable {
    let show: Show
}

struct Show: Codable {
    let name: String
    let image: Image
    let rating: Rating
}

struct Image: Codable {
    let original: String?
}

struct Rating: Codable {
    let average: Double?
}

