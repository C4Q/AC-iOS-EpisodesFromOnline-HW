//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit
struct Show: Codable {
    let show: ShowWrapper
}
struct ShowWrapper:Codable {
    let id : Int
    let name: String
    let rating:RatingWrapper
    let image: ImageWrapper?
}
struct RatingWrapper: Codable {
    let average: Double?
}
struct ImageWrapper:Codable {
    let medium: String?
    let original: String?
}

