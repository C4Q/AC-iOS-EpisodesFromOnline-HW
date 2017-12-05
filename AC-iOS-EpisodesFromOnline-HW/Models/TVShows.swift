//
//  TVShows.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
//Since it is an array of dicts, we have to enter the array:


class TVShowsAPIClient {
    private init() {}
    static let manager = TVShowsAPIClient()
    func getTvShows(from urlStr: String, completionHandler: @escaping ([TVSeries]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let onlineTVShows = try JSONDecoder().decode([TVSeries].self, from: data)
                completionHandler(onlineTVShows)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}


struct bunchOfTVSeries: Codable {
    let tvSeries: [TVSeries]
}

struct TVSeries: Codable {
    let show: Show
}

struct Show: Codable {
    let id: Int
    let url: String
    let name: String
    let summary: String
    let rating: Rating?
    let image: ImageLinks?
}

struct Rating: Codable {
    let average: Double?
}

struct ImageLinks: Codable {
    let medium: String?
    let original: String?
}

/*
 Array of Dicts
 http://api.tvmaze.com/search/shows?q=\(searchWord)
 [
 {
 "score": 17.262135,
 "show": {
 "id": 139,
 "url": "http://www.tvmaze.com/shows/139/girls",
 "name": "Girls",
 "type": "Scripted",
 "language": "English",
 "genres": [
 "Drama",
 "Romance"
 ],
 "status": "Ended",
 "runtime": 30,
 "premiered": "2012-04-15",
 "officialSite": "http://www.hbo.com/girls",
 "schedule": {
 "time": "22:00",
 "days": [
 "Sunday"
 ]
 },
 "rating": {
 "average": 6.7
 },
 "weight": 91,
 "network": {
 "id": 8,
 "name": "HBO",
 "country": {
 "name": "United States",
 "code": "US",
 "timezone": "America/New_York"
 }
 },
 "webChannel": null,
 "externals": {
 "tvrage": 30124,
 "thetvdb": 220411,
 "imdb": "tt1723816"
 },
 "image": {
 "medium": "http://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
 "original": "http://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
 },
 "summary": "<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>",
 "updated": 1504686061,
 "_links": {
 "self": {
 "href": "http://api.tvmaze.com/shows/139"
 },
 "previousepisode": {
 "href": "http://api.tvmaze.com/episodes/1079686"
 }
 }
 }
 },*/
