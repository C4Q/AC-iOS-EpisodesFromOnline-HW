//
//  EpisodesBySeasonBrain.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodesBySeasonBrain {
    
    func makeSeasonsDict(episodes: [Episode]) -> [Int : [Int : Episode]] {
        var allSeasonsDict = [Int : [Int : Episode]]()
        for episode in episodes {
            if allSeasonsDict[episode.season!] == nil {
                allSeasonsDict[episode.season!] = [Int : Episode]()
                allSeasonsDict[episode.season!]![episode.number!] = episode
            } else {
                var currentSeason = allSeasonsDict[episode.season!]
                currentSeason![episode.number!] = episode
                allSeasonsDict[episode.season!] = currentSeason
            }
        }
        return allSeasonsDict
    }
    
    func getSeasonKeys(seasonsDict: [Int : [Int : Episode]]) -> [Int] {
        return seasonsDict.keys.sorted()
    }
    
    func getEpisodeKeys(seasonsDict: [Int : [Int : Episode]], seasonKeys: [Int]) -> [Int: [Int]] {
        var nestedKeyDict = [Int : [Int]]()
        for i in 0..<seasonKeys.count {
            let array = seasonsDict[seasonKeys[i]]?.keys.sorted()
            nestedKeyDict[seasonKeys[i]] = array
        }
        return nestedKeyDict
    }

}
