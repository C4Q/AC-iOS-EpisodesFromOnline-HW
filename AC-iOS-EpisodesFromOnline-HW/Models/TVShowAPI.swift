//
//  TVShowAPI.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct TVShowAPIClient {
    private init() {}
    static let manager = TVShowAPIClient()
    func getTVShows(from urlStr: String, completionHandler: @escaping ([Show]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let showInfoArray = try JSONDecoder().decode([ShowInfo].self, from: data)
                var shows: [Show] = []
                for showInfo in showInfoArray {
                   shows.append(showInfo.show)
                }
                completionHandler(shows)
            }
                
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
            
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
