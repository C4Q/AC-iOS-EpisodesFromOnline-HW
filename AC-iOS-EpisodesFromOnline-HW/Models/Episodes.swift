//
//  Episodes.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodesAPIClient {
    private init() {}
    static let manager = EpisodesAPIClient()
    func getAllEpisodes(from urlStr: String, completionHandler: @escaping ([Episodes]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let onlineEpisodes = try JSONDecoder().decode([Episodes].self, from: data)
                completionHandler(onlineEpisodes)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}


struct allEpisodes: Codable {
    let seriesInstallments: Episodes
}

struct Episodes: Codable {
    let name: String
    let id: Int
    let url: String
    let season: Int
    let number: Int
    let summary: String?
    let image: ImageURLs?
    
}

struct ImageURLs: Codable {
    let original: String?
    let medium: String?
}


/*
 Array of Dicts
 http://api.tvmaze.com/shows/:id/episodes
  http://api.tvmaze.com/shows/3723/episodes
 [
 {
 "id": 239704,
 "url": "http://www.tvmaze.com/episodes/239704/the-cat-1x01-to-kill-a-priest",
 "name": "To Kill a Priest",
 "season": 1,
 "number": 1,
 "airdate": "1966-09-16",
 "airtime": "",
 "airstamp": "1966-09-16T16:00:00+00:00",
 "runtime": 30,
 "image": null,
 "summary": "",
 "_links": {
 "self": {
 "href": "http://api.tvmaze.com/episodes/239704"
 }
 }
 }
 ]
 
 
 */
