//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

enum JSONError: Error {
    case decodingError(Error)
}

struct AirtableResponse: Codable {
    let showWrapper: [ShowWrapper]
}

struct ShowWrapper:Codable{
    let show:Shows
}

struct Shows:Codable{
    static func getShows(from jsonData: Data) throws -> [Shows] {
        let response = try JSONDecoder().decode(AirtableResponse.self, from: jsonData)
        return response.showWrapper.map { $0.show}
    }
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
