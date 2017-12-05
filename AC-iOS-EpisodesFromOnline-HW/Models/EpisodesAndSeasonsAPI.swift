//
//  EpisodesAndSeasonsAPI.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct EpisodeAndSeasonAPI {
    private init() {}
    static let manager = EpisodeAndSeasonAPI()
    func getEpisodes(from urlStr: String, completionHandler: @escaping ([Episode]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
           errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let episodeInfoArray = try JSONDecoder().decode([Episode].self, from: data)
                
               completionHandler(episodeInfoArray)
            }
            catch {
                print(error)
                 errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}

