//
//  Episode.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Decodable{
    var name: String?
    var season: Int?
    var number: Int?
    var image: EpisodeImage?
    var summary: String?
}

struct EpisodeImage: Decodable{
    var medium: String?
    var original: String?
}
