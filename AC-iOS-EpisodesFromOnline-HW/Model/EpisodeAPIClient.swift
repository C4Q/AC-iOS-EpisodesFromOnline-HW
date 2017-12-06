//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodeAPIClient {
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from showID: Int, completionHandler: @escaping ([Episode]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlString = "http://api.tvmaze.com/shows/\(showID)/episodes"
        
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badURL)
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data) in
                do {
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    
                    completionHandler(episodes)
                } catch let error {
                    errorHandler(AppError.cannotParseJSON(rawError: error))
                }
        },
            errorHandler: errorHandler)
    }
}
