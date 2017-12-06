//
//  TVShows.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShows: Codable {
    let show: Show
}

struct Show: Codable {
    let id: Int
    let name: String?
    let rating: Rating?
    let image: Image?
    let url: String?
}

struct Image: Codable {
    let medium: String?
    let original: String?
}

struct Rating: Codable {
    let average: Double?
}


