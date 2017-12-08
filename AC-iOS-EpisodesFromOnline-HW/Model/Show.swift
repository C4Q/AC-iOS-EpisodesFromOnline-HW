//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ShowInfo: Codable {
    let show: Show
}
struct Show: Codable {
    let id: Int
    let name: String?
    let rating: Rating
    let image: Image?
}
struct Rating: Codable {
    let average: Double?
}
struct Image: Codable {
    let original: String?
}
