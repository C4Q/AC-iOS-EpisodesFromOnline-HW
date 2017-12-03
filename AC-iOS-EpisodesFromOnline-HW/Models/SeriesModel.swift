//
//  SeriesModel.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Show: Codable {
    var name: String
    var season: Int
    var number: Int
    var summary: String
    var image: SeriesImageWrapper?
}

struct SeriesImageWrapper: Codable {
    var medium: String?
    var original: String?
}



