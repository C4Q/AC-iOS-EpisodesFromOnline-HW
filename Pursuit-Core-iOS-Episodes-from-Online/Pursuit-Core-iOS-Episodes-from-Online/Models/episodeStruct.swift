//
//  episodeStruct.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    let name : String
    let season: Int
    let image: Image?
    
    static func getEpisodeData(showID: Int, completionHandler: @escaping (Result<[Episode],AppError>) -> () ) {
        let url = "http://api.tvmaze.com/shows/\(showID)/episodes"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let episodeData = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(episodeData))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}

struct Image: Codable {
    let medium: String
    let original: String
}
