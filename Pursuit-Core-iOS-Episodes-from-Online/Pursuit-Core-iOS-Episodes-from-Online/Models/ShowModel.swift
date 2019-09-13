//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Shows: Codable {
    let show: Show
}

struct Show: Codable {
    let id: Int
    let name: String
    let image: Image?
}
