//
//  EpisodesModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Malcolm S. Turnquest on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Episodes: Codable{
    let name: String?
    let season: Int?
    let number: Int?
    let summary: String?
    let image: imageGet?
    var fixedSummary: String{
        if let summary = summary{
         return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
        return ""
    }
    var episodeFormat: String{
        if let season = season{
            if let episode = number{
                return "S:\(season.description) E: \(episode)"
            }
        }
        return "No season Info"
    }

    
    static func getEpisode(id: Int,completionHandler: @escaping (Result<[Episodes],AppError>) -> () ) {
        
           let url = "https://api.tvmaze.com/shows/\(id)/episodes"
        
        NetWorkManager.shared.fetchData(urlString: url) { (result) in
            
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedShow = try JSONDecoder().decode([Episodes].self, from: data)
                    completionHandler(.success(decodedShow))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}
struct imageGet: Codable{
    let medium: String?
    let original: String?
}
