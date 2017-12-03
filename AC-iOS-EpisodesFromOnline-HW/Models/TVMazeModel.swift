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
    var name: String //Show Name
    var rating: RatingWrapper
    var image: ImageWrapper?
    var _links: SelfWrapper
    

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


