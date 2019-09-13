//
//  Episodes.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episodes: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: Image?
}
