//
//  SearchModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let score: Double
    let show: Show
    
    static func loadShows(search: String?, completionHandler: @escaping (Result<[SearchResult],AppError>) -> () ) {
        
        var url = ""
        if let searchWord = search?.lowercased() {
            url = "http://api.tvmaze.com/search/shows?q=\(searchWord)"
        }
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let shows = try JSONDecoder().decode([SearchResult].self, from: data)
                    completionHandler(.success(shows))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}

struct Show: Codable {
    let genres: [String]
    let id: Int
    let image: Image?
    let links: Links
    let name: String
    let rating: Rating
    let runtime: Int?
    let schedule: Schedule
    let status: String
    let summary: String?
    let url: String
}

struct Schedule: Codable {
    let days: [String]
    let time: String
}

struct Rating: Codable {
    let average: Double?
}

struct Country: Codable {
    let code: String
    let name: String
    let timezone: String
}

struct Links: Codable {
    let previousEpisode: Previousepisode?
    let currentEpisode: Previousepisode
}

struct Previousepisode: Codable {
    let href: String
}

struct Image: Codable {
    let medium: String
    let original: String
}


extension Links {
    enum CodingKeys: String, CodingKey {
        case previousEpisode = "previousepisode"
        case currentEpisode = "self"
    }
}

extension Show {
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
        case id = "id"
        case image = "image"
        case links = "_links"
        case name = "name"
        case rating = "rating"
        case runtime = "runtime"
        case schedule = "schedule"
        case status = "status"
        case summary = "summary"
        case url = "url"
    }
}
