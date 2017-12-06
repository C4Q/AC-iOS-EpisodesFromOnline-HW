//
//  TVShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct TVShowAPIClient {
    private init() {}
    static let manager = TVShowAPIClient()
    func getTVShows(from url: String,
                    completionHandler: @escaping ([TVShows]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: url) else { return }
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let tvShowInfo = try JSONDecoder().decode([TVShows].self, from: data)
                completionHandler(tvShowInfo)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
