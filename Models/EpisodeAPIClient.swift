//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodeAPIClient {
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from urlStr: String, completionHandler: @escaping ([Episode]) -> Void, ErrorHandler: @escaping (Error) -> Void) {
        //this is where you tell it to decode it as a dict or an array
        guard let url = URL(string: urlStr) else {return}
        //if there is no url, return and stop running
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let episode = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(episode)
            } catch let error {
                ErrorHandler(error)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: ErrorHandler)
    }
}
