//
//  EpisodeStruct.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kevin Natera on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit

struct Episode : Codable {
    let name: String
    let season: Int
    let number: Int
    let image: EpisodeImageWrapper?
    let summary: String?
    var updatedSummary: String {
        let i = (summary?.replacingOccurrences(of: "<p>", with: ""))
        return i?.replacingOccurrences(of: "</p>", with: "") ?? ""
    }
    
    static func getEpisode(id: Int,completionHandler: @escaping (Result<[Episode],Error>) -> () ) {
        let url = "http://api.tvmaze.com/shows/\(id)/episodes"
        
        NetworkManager.shared.getData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(episodes))
                } catch {
                    completionHandler(.failure(ErrorHandling.decodingError))
                    print(error)
                }
            }
        }
    }
}

struct EpisodeImageWrapper : Codable {
    let medium: String?
    let original: String?
}
