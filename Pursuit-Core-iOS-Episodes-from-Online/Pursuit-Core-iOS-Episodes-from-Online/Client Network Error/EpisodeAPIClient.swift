//
//  EpisodeAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/22/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class EpisodeAPIClient {
    private init () {}
    
    static var shared = EpisodeAPIClient()
    
    func getEpisodes(showID: String, completionHandler: @escaping (Result<[Episode], AppError>) -> () ) {
        let urlStr = "http://api.tvmaze.com/shows/\(showID)/episodes"
        
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure( _):
                completionHandler(.failure(.badURL))
            case .success(let data):
                do {
                    let episodeInfo = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(episodeInfo))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
                
            }
        }
        
    }
}
