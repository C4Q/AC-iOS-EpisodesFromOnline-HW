//
//  EpisodesModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/22/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

//http://api.tvmaze.com/shows/139/episodes


struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: ImageEpisodeWrapper?
    let summary: String
    var cleanedSummary: String {
        return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    var seasonAndEpisode: String {
        return "Season: \(season.description) Episode: \(number.description)"
    }
}

struct ImageEpisodeWrapper: Codable {
    let medium: String
    let original: String
}

//[
//    {
//        "id": 1,
//        "url": "http://www.tvmaze.com/episodes/1/under-the-dome-1x01-pilot",
//        "name": "Pilot",
//        "season": 1,
//        "number": 1,
//        "airdate": "2013-06-24",
//        "airtime": "22:00",
//        "airstamp": "2013-06-25T02:00:00+00:00",
//        "runtime": 60,
//        "image": {
//            "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
//            "original": "http://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
//        },
//        "summary": "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
//        "_links": {
//            "self": {
//                "href": "http://api.tvmaze.com/episodes/1"
//            }
//        }
//    },
