//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Keshawn Swanston on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class EpisodeAPIClient{
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from urlStr: String,
                 completionHandler: @escaping ([Episode]) -> Void,
                 errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                completionHandler(episodes)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
