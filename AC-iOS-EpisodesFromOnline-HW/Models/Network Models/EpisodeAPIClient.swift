//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct EpisodeAPIClient {
    private init() {}
    
    static let manager = EpisodeAPIClient()
    
    func getTVShows(from url: String,
                    completionHandler: @escaping ([Episode]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let tvShowInfo = try JSONDecoder().decode([Episode].self, from: data)
                completionHandler(tvShowInfo)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
