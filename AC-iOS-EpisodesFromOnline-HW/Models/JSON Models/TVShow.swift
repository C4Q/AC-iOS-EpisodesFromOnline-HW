//
//  TVShow.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let show: Show
}

struct Show: Codable {
    let id: Int
    let url: String?
    let name: String?
    let image: Image?
    let rating: Rating?
}

struct Image: Codable {
    let medium: String?
    let original: String?
}

struct Rating: Codable {
    let average: Double?
}
