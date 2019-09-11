//
//  EpisodesModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let name: String?
    let season: Int?
    let number: Int?
    let summary: String?
    let image: ImageWrapper?
    
    var seasonAndEpisode: String{
        if let episode = number{
            if let season = season {
                return "Season: \(season.description) Episode: \(episode)"
            }
        }
        return ""
    }
    
    var updatedSummary: String {
        if let summary = summary {
            let newSummary = summary.replacingOccurrences(of: "<p>", with: "")
            let newNewSummary = newSummary.replacingOccurrences(of: "</p>", with: "")
            return newNewSummary
        }
        if summary == " "{
        return "Summary Unavailable"
        }
        return ""
    }
    
    static func getEpisode(episodeID: Int,completionHandler: @escaping (Result<[Episode],AppError>) -> () ) {
        
        let url = "https://api.tvmaze.com/shows/\(episodeID)/episodes"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(decoded))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}

struct ImageWrapper: Codable{
    let medium: String?
    let original: String?
}


