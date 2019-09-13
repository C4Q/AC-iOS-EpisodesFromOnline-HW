//
//  showsStruct.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Show: Codable {
    
    let name: String
        let rating: ratingWrapper?
        let image: ImageWrapper
        let id: Int
    
    
    
    //    let summary: String
    
    static func getShowData(completionHandler: @escaping (Result<[Show],AppError>) -> () ) {
        let url = "http://api.tvmaze.com/shows"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let showData = try JSONDecoder().decode([Show].self, from: data)
                    completionHandler(.success(showData))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
    
    
   static func getFilteredShowsByName(arr: [Show], searchString: String ) -> [Show]{ //I want this to take in an array of Show, filter it by the string that I give it, and then return all the shows that match that string.
        return arr.filter{$0.name.lowercased().contains(searchString.lowercased())}
        
        
    }
}


struct ImageWrapper: Codable {
    let medium: String
    let original: String
}

struct ratingWrapper: Codable {
    let average: Double?
}

