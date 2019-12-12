//
//  Show.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowWrapper: Codable {
    let show: Show
}

struct Show: Codable {
    let id: Int
    let name: String
    let image: Image?
    let rating: Rating
}

struct Image: Codable {
    let medium: String
    var secureMedium: String {
        "https" + medium.dropFirst(4)
    }
}

struct Rating: Codable {
    let average: Double?
}
