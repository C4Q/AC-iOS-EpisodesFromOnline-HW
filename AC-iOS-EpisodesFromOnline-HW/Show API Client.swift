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
                   completionHandler: @escaping ([Show]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let show = try JSONDecoder().decode([Show].self, from: data)
                completionHandler(show)
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
