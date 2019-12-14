//
//  EpisodeModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Decodable {
    var name :String
    var season: Int
    var episode: Int
    var image: EpisodeImageURL?
    private enum CodingKeys: String, CodingKey{
        case name
        case season
        case episode = "number"
        case image
    }
}

struct EpisodeImageURL:Decodable {
    var medium: String
    var original:String
}
