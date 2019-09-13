//
//  TVEpisodes.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Eric Widjaja on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct TVEpisodes: Codable {
    let number: Int
    let name: String
    let season: Int
    let image: TVEpisodeImage?
    let summary: String?
    
    static func getTVEpisode(showURL: String, completionHandler: @escaping (Result<[TVEpisodes],AppError>) -> () ) {
        
        NetworkManager.shared.fetchData(urlString: showURL) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let TVEpisodesData = try JSONDecoder().decode([TVEpisodes].self, from: data)
                    completionHandler(.success(TVEpisodesData))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}

struct TVEpisodeImage: Codable {
    let original: String
}
