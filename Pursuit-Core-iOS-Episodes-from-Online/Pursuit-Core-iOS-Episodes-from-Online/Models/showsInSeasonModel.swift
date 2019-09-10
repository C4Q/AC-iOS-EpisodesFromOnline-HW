//
//  showsInSeasonModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
struct Episode:Codable{
    let id:Int
    let name:String
    let season:Int
    let number:Int
    let image:EpisodeImages
    let summary:String
}
struct EpisodeImages:Codable{
    let medium:String
    let original:String
}
