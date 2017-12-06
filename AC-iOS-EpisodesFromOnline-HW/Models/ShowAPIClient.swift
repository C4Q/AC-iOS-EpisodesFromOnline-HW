//
//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ShowAPIClient {
    private init() {}
    static let manager = ShowAPIClient()
    func getShows(from urlStr: String, completionHandler: @escaping ([Show]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let decoder = JSONDecoder()
                let shows = try decoder.decode([Show].self, from: data)
                completionHandler(shows)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
