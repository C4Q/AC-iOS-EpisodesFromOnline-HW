//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit


struct ShowWrapper:Codable{
    let show:Shows
}

struct Shows:Codable{
    let id:Int
    let name:String
    let premiered: String
    let image:Images
    let genres: Genres
    let rating: Rating
}

struct Images:Codable {
    let medium:String
    let original:String
}
struct Genres:Codable {
    let genre: [String]
}
struct Rating: Codable {
    let average: Double
}
