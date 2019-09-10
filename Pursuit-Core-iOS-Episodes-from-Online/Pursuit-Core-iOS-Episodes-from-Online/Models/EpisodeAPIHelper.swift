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
    
    
    func getUrl(str:String) -> String {
        return "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=\(str)&apikey=261deb4710e0b9d1cd52b236a620d02d"
    }
    
   
    
    
    mutating func getEpisodes(url: String, completionHandler: @ escaping (Result<[Episodes], AppError>) -> ()) {
    
        
        NetworkManager.shared.fetchData(urlString: getUrl(str: url)) {
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
