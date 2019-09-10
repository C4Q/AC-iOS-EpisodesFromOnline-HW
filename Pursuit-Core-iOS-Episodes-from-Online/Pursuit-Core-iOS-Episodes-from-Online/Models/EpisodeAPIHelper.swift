//
//  EpisodeAPIHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct  EpisodesAPIHelper {
    private init() {}
    
    static var shared = EpisodesAPIHelper()
    
    
    func getUrl(id:Int) -> String {
        return "http://api.tvmaze.com/shows/\(128)/episodes"
    }
    
   
    
    
    mutating func getEpisodes(id: Int, completionHandler: @ escaping (Result<[Episodes], AppError>) -> ()) {
    
        
        NetworkManager.shared.fetchData(urlString: getUrl(id: id)) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let episodeInfo = try JSONDecoder().decode([Episodes].self, from: data)
                    completionHandler(.success(episodeInfo))
                    
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
