//
//  episodeModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by hildy abreu on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
struct ShowModel: Codable {
    let show: ShowInfo
    let rating: RatingInfo
    let image: ImageDetail
}

struct ShowInfo: Codable {
    let id:Int
    let url:String
    let name: String
    let type: String
    let language: String
}

struct RatingInfo: Codable {
    let average: Double
}

struct ImageDetail: Codable {
    let medium: String
    let original: String
}

