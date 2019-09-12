//
//  showsInSeasonModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit

struct Episode:Codable{
    let id:Int
    let url:String
    let name:String
    let season:Int
    let number:Int
    let image:EpisodeImages?
    let summary:String?
    var seasonNameAndNumber:String {
        return getSeasonNumberAndEpisodeNumber()
    }

        func checkSummary() -> String {
            if summary == "" {
                return "A summary for this episode is not available. Please contact tvmaze at this address [\(url)] to complain."
            } else {
                return summary ?? "A summary for this episode is not available. Please contact tvmaze at this address [\(url)] to complain."
        }
    }
    
    func getSeasonNumberAndEpisodeNumber() -> String {
        return "Season \(season): Episode \(number)"
    }
}
struct EpisodeImages:Codable{
    let medium:String
    let original:String
}
