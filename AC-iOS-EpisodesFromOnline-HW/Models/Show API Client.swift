//
//  Show API Client.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct ShowsAPIClient {
    private init(){}
    static let shared = ShowsAPIClient()
    func getShows(from urlStr: String,
                   completionHandler: @escaping ([ShowWrapper]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let shows = try JSONDecoder().decode([ShowWrapper].self, from: data)
                var theseShows: [ShowWrapper] = []
                for show in shows {
                    theseShows.append(show)
                }
                completionHandler(theseShows)
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
