//
//  EpisodeAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
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
