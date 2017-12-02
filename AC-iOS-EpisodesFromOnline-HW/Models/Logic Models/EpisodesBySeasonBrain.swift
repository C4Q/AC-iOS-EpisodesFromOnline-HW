//
//  EpisodesBySeasonBrain.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodesBySeasonBrain {

    // make dict to hold other dicts
    
    // loop through all episode
    
    // check if new season
    
    // if it is create a new dictionary as the value
    
    // add episode.number = episode to new dictionary
    
    // if not new season
    
    // update that seasons value dict with new episode
    
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
    
}
