//
//  AmazeTVAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class TVMazeAPIClient {
    private init() {}
    static let manager = TVMazeAPIClient()
    func getShow(from searchStr: String,
                 completionHandler: @escaping ([TVMaze]) -> (Void),
                 errorHandler: @escaping (Error) -> Void) {
        
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchStr)"
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let showInfo = try JSONDecoder().decode([TVMaze].self, from: data)
                completionHandler(showInfo)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

class EpisodeAPIClient {
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from urlStr: String,
                     completionHandler: @escaping ([Episode]) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let episode = try JSONDecoder().decode([Episode].self, from: data)
                completionHandler(episode)
            } catch let error {
                errorHandler(error)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

