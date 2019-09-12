//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Shows: Codable {
    let show: Show
}

struct Show: Codable {
    let name: String
    let image: Image?
    
    struct Image: Codable {
        let medium: String
        let original: String
    }
}
//
//struct Episodes: Codable {
//    let name: String
//    let season: Int
//    let number: Int
//    let image: EpisodeImage
//    let summary: String
//}
//
//struct ShowImage: Codable {
//    let medium: String
//    let original: String
//}
//
//struct EpisodeImage: Codable {
//    let medium: String
//    let original: String
//}
//

////{
//"id": 139,
//"url": "http://www.tvmaze.com/shows/139/girls",
//"name": "Girls",
//"type": "Scripted",
//"language": "English",
//"genres": [
//"Drama",
//"Romance"
//],
//"status": "Ended",
//"runtime": 30,
//"premiered": "2012-04-15",
//"officialSite": "http://www.hbo.com/girls",
//"schedule": {
//    "time": "22:00",
//    "days": [
//    "Sunday"
//    ]
//},
//"rating": {
//    "average": 6.9
//},
//"weight": 90,
//"network": {
//    "id": 8,
//    "name": "HBO",
//    "country": {
//        "name": "United States",
//        "code": "US",
//        "timezone": "America/New_York"
//    }
//},
//"webChannel": null,
//"externals": {
//    "tvrage": 30124,
//    "thetvdb": 220411,
//    "imdb": "tt1723816"
//},
//"image": {
//    "medium": "http://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
//    "original": "http://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
//},
//"summary": "<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>",
//"updated": 1543140952,
//"_links": {
//    "self": {
//        "href": "http://api.tvmaze.com/shows/139"
//    },
//    "previousepisode": {
//        "href": "http://api.tvmaze.com/episodes/1079686"
//    }
//},
//"_embedded": {
//    "episodes": [
//    {
//    "id": 10820,
//    "url": "http://www.tvmaze.com/episodes/10820/girls-1x01-pilot",
//    "name": "Pilot",
//    "season": 1,
//    "number": 1,
//    "airdate": "2012-04-15",
//    "airtime": "22:30",
//    "airstamp": "2012-04-16T02:30:00+00:00",
//    "runtime": 30,
//    "image": {
//    "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/15/38639.jpg",
//    "original": "http://static.tvmaze.com/uploads/images/original_untouched/15/38639.jpg"
//    },
//    "summary": "<p>In the premiere of this comedy about twentysomething women navigating their way through life in New York, Hannah swings and misses at two curves when her parents rescind their financial support and she loses her unpaid internship. Meanwhile, Hannah's roommate, Marnie, throws a dinner party for their nomadic friend Jessa, who's returned from yet another journey.</p>",
//    "_links": {
//    "self": {
//    "href": "http://api.tvmaze.com/episodes/10820"
//    }
//    }
//}
