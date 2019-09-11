//
//  ShowStruct.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kevin Natera on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit


struct ShowWrapper : Codable {
    let show: Shows
    
    static func getShow(userInput: String?,completionHandler: @escaping (Result<[ShowWrapper],Error>) -> () ) {
        var url = ""
        if let word = userInput {
            let searchString = word.replacingOccurrences(of: " ", with: "-")
            url = "https://api.tvmaze.com/search/shows?q=\(searchString)"
        }
        NetworkManager.shared.getData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let shows = try JSONDecoder().decode([ShowWrapper].self, from: data)
                    completionHandler(.success(shows))
                } catch {
                    completionHandler(.failure(ErrorHandling.decodingError))
                    print(error)
                }
            }
        }
    }
}


struct Shows : Codable {
    let name: String
    let id: Int
    let rating: RatingWrapper?
    let image: ImageWrapper?
}

struct RatingWrapper : Codable {
    let average: Double?
}

struct ImageWrapper: Codable{
    let medium: String?
    let original: String?
}
