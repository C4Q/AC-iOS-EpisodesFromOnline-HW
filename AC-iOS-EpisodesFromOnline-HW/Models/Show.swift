//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Ashlee Krammer on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Show: Codable{
    let show: ShowWrapper
}
struct ShowWrapper: Codable {
    let id: Int
    let name: String
    let rating: RatingWrapper?
    let image: Image?
    
}

struct Image: Codable{
    let medium: String?
    let original: String?
}


struct RatingWrapper: Codable {
    let average: Double?
}
