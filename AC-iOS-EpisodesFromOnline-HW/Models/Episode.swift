//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Response: Codable {
    let _embedded: EmbeddedWrapper
}

struct EmbeddedWrapper: Codable {
    let episodes: [Episode]
}

struct Episode: Codable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let airtime: String
    let airstamp: String?
    let runtime: Int?
    let image: EpisodeImageWrapper?
    let summary: String?
    let _links: EpisodeLinksWrapper
    
    static func makeTupleBySeasons(allEpisodes: [Episode]) -> [(key: Int, value: [Episode])]{
        var allEpisodesBySeasonDict = [Int: [Episode]]()
        //let allShowEpisodes = allEpisodes
        for episode in allEpisodes {
            if let episodesSoFar = allEpisodesBySeasonDict[episode.season] {
                var toAddNewEpisode: [Episode] = episodesSoFar
                toAddNewEpisode.append(episode)
                allEpisodesBySeasonDict.updateValue(toAddNewEpisode, forKey: episode.season)
            } else {
                allEpisodesBySeasonDict.updateValue([episode], forKey: episode.season)
            }
        }
        return allEpisodesBySeasonDict.sorted{$0.key < $1.key}
    }
    
}

struct EpisodeImageWrapper: Codable {
    let medium: String
    let original: String
}

struct EpisodeLinksWrapper: Codable {
    let `self`: EpisodeSelfWrapper
}

struct EpisodeSelfWrapper: Codable {
    let href: String
}
