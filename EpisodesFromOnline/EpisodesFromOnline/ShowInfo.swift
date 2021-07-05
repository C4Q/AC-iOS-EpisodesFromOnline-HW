//
//  ShowInfo.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/11/19.
//

import Foundation

struct AllInfo: Codable {
    let show : ShowInfo
}

struct ShowInfo: Codable {
    let id: Int
    let name: String
    let image: ImageInfo?
    let rating: RatingInfo
}

struct ImageInfo: Codable {
    let medium: String
    let original: String
}

struct RatingInfo: Codable {
    let average: Double?
}



