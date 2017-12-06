//
//  EpisodesAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class EpisodesAPIClient {
    //Below we are setting up the things that are required win the perform data task
    //This is a singleton because we only want one APIClient.
    private init() {}
    static let manager = EpisodesAPIClient()
    func getEpisodes(from urlStr: String,
                  completionHandler: @escaping ([Episodes]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        //Convert data to Shows
        let completion: (Data) -> Void = {(data: Data) in
            do {
                //The below is telling the network helper what to do when it gets data
                let episode = try JSONDecoder().decode([Episodes].self, from: data)
                completionHandler(episode)
            }
            catch let error {
                errorHandler(error)
            }
        }
        
        //In this part, it actually talks to internet
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
