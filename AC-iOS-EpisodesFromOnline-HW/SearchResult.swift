//
//  SearchResult.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Masai Young on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let score: Double
    let show: Show
}

struct Show: Codable {
    let externals: Externals
    let genres: [String]
    let id: Int
    let image: Image?
    let language: String
    let links: Links
    let name: String
    let network: Network?
    let officialSite: String?
    let premiered: String?
    let rating: Rating
    let runtime: Int?
    let schedule: Schedule
    let status: String
    let summary: String?
    let type: String
    let updated: Int
    let url: String
    let webChannel: WebChannel?
    let weight: Int
}

struct WebChannel: Codable {
    let country: Country?
    let id: Int
    let name: String
}

struct Schedule: Codable {
    let days: [String]
    let time: String
}

struct Rating: Codable {
    let average: Double?
}

struct Network: Codable {
    let country: Country
    let id: Int
    let name: String
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

struct Externals: Codable {
    let imdb: String?
    let thetvdb: Int?
    let tvrage: Int?
}

extension Links {
    enum CodingKeys: String, CodingKey {
        case previousEpisode = "previousepisode"
        case currentEpisode = "self"
    }
}

extension Show {
    enum CodingKeys: String, CodingKey {
        case externals = "externals"
        case genres = "genres"
        case id = "id"
        case image = "image"
        case language = "language"
        case links = "_links"
        case name = "name"
        case network = "network"
        case officialSite = "officialSite"
        case premiered = "premiered"
        case rating = "rating"
        case runtime = "runtime"
        case schedule = "schedule"
        case status = "status"
        case summary = "summary"
        case type = "type"
        case updated = "updated"
        case url = "url"
        case webChannel = "webChannel"
        case weight = "weight"
    }
}

