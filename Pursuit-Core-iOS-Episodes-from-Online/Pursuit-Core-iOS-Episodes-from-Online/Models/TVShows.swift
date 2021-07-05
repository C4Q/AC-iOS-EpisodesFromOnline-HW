//
//  TVShows.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Eric Widjaja on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let image: Image
    let rating: Rating?
    let genres: [String]
    
    static func getTVShowData(completionHandler: @escaping (Result<[TVShow],AppError>) -> () ) {
        let url = "http://api.tvmaze.com/shows"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let showData = try JSONDecoder().decode([TVShow].self, from: data)
                    completionHandler(.success(showData))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
    //MARK: Array to sort the titles
    static func getSortedArray(arr: [TVShow]) -> [TVShow] {
        let TVShowArrSorted = arr.sorted{$0.name < $1.name}
        return TVShowArrSorted
    }
    
    static func getFilteredTVShows(arr: [TVShow], searchString: String) -> [TVShow] {
        return arr.filter{$0.name.lowercased().contains(searchString.lowercased())}
    }

}

struct Image: Codable {
    let original: String
}

struct Rating: Codable {
    let average: Double?
}

