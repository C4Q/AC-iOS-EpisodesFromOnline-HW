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
}


struct ImageWrapper: Codable {
    let medium: String
    let original: String
}

struct ratingWrapper: Codable {
    let average: Double?
}


