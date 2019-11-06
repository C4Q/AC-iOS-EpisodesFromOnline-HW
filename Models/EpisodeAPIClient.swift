//
//  EpisodeAPIClient.swift
//  Unit3Week2HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct EpisodeAPIClient {
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from urlStr: String,
                     completionHandler: @escaping ([Episode]) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        print(urlStr)
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let onlineEpisodes = try JSONDecoder().decode([Episode].self, from: data)
                completionHandler(onlineEpisodes)
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
