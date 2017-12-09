//
//  ShowsAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ShowsAPIClient {
    private init() {}
    static let manager = ShowsAPIClient()
    func getShows(from urlStr: String,
                  completionHandler: @escaping ([Shows]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineShows = try JSONDecoder().decode([Shows].self, from: data)
                completionHandler(onlineShows)
            } catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
