//
//  AmazeTV.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct AmazeTV: Codable {
    let show: Show
}

struct Show: Codable {
    let name: String
    let image: Image?
    let rating: Rating
    let summary: String?
    let id: Int
}

struct Image: Codable {
    let medium: String?
    let original: String?
}

struct Rating: Codable {
    let average: Double?
}
