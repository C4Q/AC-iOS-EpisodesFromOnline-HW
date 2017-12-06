//
//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ShowAPIClient {
    private init() {}
    static let manager = ShowAPIClient()
    func getShows(from searchTerm: String, completionHandler: @escaping ([Show]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlString = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badURL)
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data) in
                do {
                    let results = try JSONDecoder().decode([ResultsWrapper].self, from: data)
                    
                    let shows = results.map{$0.show}
                    
                    completionHandler(shows)
                } catch let error {
                    errorHandler(AppError.other(rawError: error))
                }
        },
            errorHandler: errorHandler)
        
    }
}
