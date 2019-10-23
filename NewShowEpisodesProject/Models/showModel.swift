//
//  showModel.swift
//  NewShowEpisodesProject
//
//  Created by hildy abreu on 10/12/19.
//  Copyright © 2019 hildy abreu. All rights reserved.
//

import Foundation

struct ShowModel: Codable {
    let show: ShowInfo
    
}

struct ShowInfo: Codable {
    let id:Int
    let url:String
    let name: String
    let type: String
    let language: String
    let rating: RatingInfo
    let image: ImageDetail?
}

struct RatingInfo: Codable {
    let average: Double?
}

struct ImageDetail: Codable {
    let medium: String
    let original: String
}

