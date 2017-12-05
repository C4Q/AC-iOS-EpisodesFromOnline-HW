//
//  Episode API Client .swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct EpisodesAPIClient {
    private init(){}
    static let shared = EpisodesAPIClient()
    func getShows(from urlStr: String,
                  completionHandler: @escaping ([Episode]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                var theseEpisodes: [Episode] = []
                for episode in episodes {
                    theseEpisodes.append(episode)
                }
                completionHandler(theseEpisodes)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
    
    
    
    
}
