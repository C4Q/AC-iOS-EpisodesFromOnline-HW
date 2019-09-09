//
//  Shows.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Show: Codable {
    let id: Int
    let name: String
    let image: Image
    let rating: Rating
    
    static func getFilteredResults(arr:[Show], searchText: String) -> [Show] {
        var currentFilter: [Show]
        currentFilter = arr.filter{$0.name.lowercased().contains(searchText.lowercased())}
        return currentFilter
    }
}


struct Image: Codable {
    let original: String
}

struct Rating: Codable {
    let average: Double?
}

