//
//  Episodes.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episodes: Codable {
    let name: String
    private let season: Int
    private let number: Int
    let image: EpisodeImage?
    private let summary: String?
    var seasonAndEpisode: String {
        return "Season: \(season)   Episode: \(number)"
    }
    var description: String {
        return (summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "no")
    }
}

struct EpisodeImage: Codable {
    let medium: String
    let original: String
}
