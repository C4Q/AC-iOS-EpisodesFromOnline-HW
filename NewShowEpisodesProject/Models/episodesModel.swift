//
//  episodesModel.swift
//  NewShowEpisodesProject
//
//  Created by hildy abreu on 10/12/19.
//  Copyright © 2019 hildy abreu. All rights reserved.
//

import Foundation

struct EpisodeModel: Codable {
    let name: String
    let season: Int
    let epiNumber: Int
    let rating: Rating?
    let image: ImageContainer?
    let summary: String
   
    enum CodingKeys: String, CodingKey {
        case name
        case season
        case epiNumber = "number"
        case rating
        case image
        case summary

    }

}
struct Rating: Codable {
    let average: Double
}

struct ImageContainer: Codable {
    let medium: String
}




