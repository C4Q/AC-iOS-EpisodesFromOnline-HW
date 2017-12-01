//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Show: Codable {
    let score: Double
    let show: ShowWrapper
}

struct ShowWrapper: Codable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String?
    let genres: [String]
    let status: String
    let runtime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: ScheduleWrapper
    let rating: RatingWrapper
    let weight: Int
    let network: NetworkWrapper?
    let webChannel: WebChannelWrapper?
    let externals: ExternalsWrapper
    let image: ShowImageWrapper?
    let summary: String?
    let updated: Int
    let _links: ShowLinksWrapper
}

struct ScheduleWrapper: Codable {
    let time: String
    let days: [String]
}

struct RatingWrapper: Codable {
    let average: Double?
}

struct NetworkWrapper: Codable {
    let id: Int
    let name: String
    let country: NetworkCountryWrapper
}

struct WebChannelWrapper: Codable {
    let id: Int
    let name: String
    let country: WebChannelCountryWrapper?
}

struct WebChannelCountryWrapper: Codable {
    let name: String
    let code: String
    let timezone: String
}

struct NetworkCountryWrapper: Codable {
    let name: String
    let code: String
    let timezone: String
}

struct ExternalsWrapper: Codable {
    let tvrange: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct ShowImageWrapper: Codable {
    let medium: String
    let original: String
}

struct ShowLinksWrapper: Codable {
    let `self`: ShowSelfWrapper
    let previousepisode: PreviousepisodeWrapper?
}

struct ShowSelfWrapper: Codable {
    let href: String
}

struct PreviousepisodeWrapper: Codable {
    let href: String
}

