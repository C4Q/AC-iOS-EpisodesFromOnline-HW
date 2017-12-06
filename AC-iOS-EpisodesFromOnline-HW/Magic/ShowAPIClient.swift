//
//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ShowAPIClient {
    private init() {}
    static let manager = ShowAPIClient()
    
    func getShows(from urlStr: String,
                  completionHandler: @escaping ([ShowResults]) -> Void,
                  errorHandler: @escaping (AppError) -> Void) {
        
        
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let showInfo = try JSONDecoder().decode([ShowResults].self, from: data)
                completionHandler(showInfo)
            }
            catch {
                print(error)
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
