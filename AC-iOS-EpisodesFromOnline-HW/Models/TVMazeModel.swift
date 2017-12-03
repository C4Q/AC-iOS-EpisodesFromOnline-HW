//
//  TVMazeModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShows: Codable {
    //var score: Double? //Might not need this at all.
    var show: ShowInfo
}

struct ShowInfo: Codable {
    var name: String //Show Name
    var rating: RatingWrapper
    var image: ImageWrapper?
    //var summary: String // Might not need this
    var _links: SelfWrapper
    
//    enum CodingKeys: String, CodingKey { //Not sure why this isn't working. Had to add underscore to links.
//        case links = "_links"
//    }
}

struct SelfWrapper: Codable {
    var selfKeyword: HrefWrapper
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


