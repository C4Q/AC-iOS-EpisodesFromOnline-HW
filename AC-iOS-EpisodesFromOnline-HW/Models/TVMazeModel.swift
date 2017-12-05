//
//  TVMazeModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShows: Codable {
    var show: ShowInfo
}

struct ShowInfo: Codable {
    var name: String? //Show Name
    var rating: RatingWrapper?
    var image: ImageWrapper?
    var _links: SelfWrapper
    
//    Cant get this coding key to work
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case rating = "rating"
//        case image = "image"
//        case links = "_links"
//
//    }
}

struct SelfWrapper: Codable {
    var selfKeyword: HrefWrapper
    
    //This enum lets you name the data whatever you want, but link it based on the actual spelling on the JSON
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


