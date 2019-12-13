//
//  SeasonModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowData:Decodable{
    var show: Show
}

struct Show: Decodable {
    var id: Int
    var name: String
    var rating: Rating
    var image: ImageURL
}

struct Rating:Decodable {
    var average: Double?
}

struct ImageURL: Decodable {
    var medium: String
    var original: String
}
