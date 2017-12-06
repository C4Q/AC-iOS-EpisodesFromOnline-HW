//
//  TVShowsModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let show: ShowWrapper
    
}

struct ShowWrapper: Codable {
    let id : Double
    let name: String
    let genres: [String]?
    let runtime: Double?
    let rating: RatingWrapper?
    let network: NetworkWrapper?
    let image: ImageWrapper?
    let summary: String?
    let links : LinkWrapper
    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case id
        case name
        case genres
        case runtime
        case rating
        case network
        case image
        case summary
    }
}

struct RatingWrapper: Codable {
    var average: Double?
}
struct NetworkWrapper: Codable {
    let name: String //hbo
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}

struct LinkWrapper: Codable {
    //let selfKeyword: HrefWrapper
    let selfKeyword: HrefWrapper
    
    enum CodingKeys: String, CodingKey {
        case selfKeyword = "self"
    }
}

struct HrefWrapper: Codable {
    let href: String
}





