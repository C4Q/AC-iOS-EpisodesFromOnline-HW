//
//  Episode.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let image: Image?
    let summary: String?
}


