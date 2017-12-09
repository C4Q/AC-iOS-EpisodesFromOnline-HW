//
//  EpisodesAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class EpisodesAPIClient {
    private init() {}
    static let manager = EpisodesAPIClient()
    func getEpisodes(from urlStr: String,
                  completionHandler: @escaping ([Episode]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineEpisodes = try JSONDecoder().decode([Episode].self, from: data)
                completionHandler(onlineEpisodes)
            } catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
