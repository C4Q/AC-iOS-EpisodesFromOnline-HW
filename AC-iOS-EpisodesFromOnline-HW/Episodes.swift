//
//  Episodes.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Masai Young on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable {
    let airdate: String
    let airstamp: String
    let airtime: String
    let id: Int
    let image: Image?
    let links: Links
    let name: String
    let number: Int
    let runtime: Int
    let season: Int
    let summary: String?
    let url: String
}

extension Episode {
    enum CodingKeys: String, CodingKey {
        case airdate = "airdate"
        case airstamp = "airstamp"
        case airtime = "airtime"
        case id = "id"
        case image = "image"
        case links = "_links"
        case name = "name"
        case number = "number"
        case runtime = "runtime"
        case season = "season"
        case summary = "summary"
        case url = "url"
    }
}


