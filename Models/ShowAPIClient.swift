//
//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ShowAPIClient {//singleton
    private init() {}
        static let manager = ShowAPIClient()
    func getShows(from urlStr: String, completionHandler: @escaping ([Show]) -> Void, errorHandler: @escaping (Error) -> Void ) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let show = try JSONDecoder().decode([Show].self, from:  data)
                completionHandler(show)
            }catch let error{
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
