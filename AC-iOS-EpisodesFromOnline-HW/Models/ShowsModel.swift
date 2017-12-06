//
//  ShowsModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct TVShows: Codable {
    var show: ShowInfo
}

struct ShowInfo: Codable {
    var id: Int
    var name: String? //Show Name
    var rating: RatingWrapper?
    var image: ImageWrapper?
    var links: SelfWrapper
    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case id
        case name
        case rating
        case image
    }
}

struct SelfWrapper: Codable {
    var selfKeyword: HrefWrapper
    
    //This enum lets you name the data whatever you want, but link it based on the actual spelling based on the JSON
    enum CodingKeys: String, CodingKey {
        case selfKeyword = "self"
    }
}

struct HrefWrapper: Codable {
    var href: String //Interpolate like this "\(href)/episodes" to get the API link for a shows episodes
}

struct RatingWrapper: Codable {
    var average: Double? //Rating
}

struct ImageWrapper: Codable {
    var medium: String?
    var original: String?
}
