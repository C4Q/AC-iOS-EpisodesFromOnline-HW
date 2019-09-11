//
//  EpisodeModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

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
