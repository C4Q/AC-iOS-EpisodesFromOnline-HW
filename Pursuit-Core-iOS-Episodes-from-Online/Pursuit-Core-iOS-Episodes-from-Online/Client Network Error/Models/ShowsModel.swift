//
//  ShowsModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowWrapper: Codable {
    let score: Double
    let show: Shows
}

struct Shows: Codable {
    let name: String
    let image: ImageWrapper?
}

struct ImageWrapper: Codable {
    let original: String
}

//[
//    {
//        "score": 17.32404,
//        "show": {
//            "id": 139,
//            "url": "http://www.tvmaze.com/shows/139/girls",
//            "name": "Girls",
//            "type": "Scripted",
//            "language": "English",
//            "genres": [
//            "Drama",
//            "Romance"
//            ],
//            "status": "Ended",
//            "runtime": 30,
//            "premiered": "2012-04-15",
//            "officialSite": "http://www.hbo.com/girls",
//            "schedule": {
//                "time": "22:00",
//                "days": [
//                "Sunday"
//                ]
//            },
//            "rating": {
//                "average": 6.9
//            },
//            "weight": 90,
//            "network": {
//                "id": 8,
//                "name": "HBO",
//                "country": {
//                    "name": "United States",
//                    "code": "US",
//                    "timezone": "America/New_York"
//                }
//            },
//            "webChannel": null,
//            "externals": {
//                "tvrage": 30124,
//                "thetvdb": 220411,
//                "imdb": "tt1723816"
//            },
//            "image": {
//                "medium": "http://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
//                "original": "http://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
//            },
//            "summary": "<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>",
//            "updated": 1543140952,
//            "_links": {
//                "self": {
//                    "href": "http://api.tvmaze.com/shows/139"
//                },
//                "previousepisode": {
//                    "href": "http://api.tvmaze.com/episodes/1079686"
//                }
//            }
//        }
//    },
