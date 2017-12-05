//
//  ShowsAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ShowsAPIClient {
    //Below we are setting up the things that are required win the perform data task
    //This is a singleton because we only want one APIClient.
    private init() {}
    static let manager = ShowsAPIClient()
    func getShows(from urlStr: String,
                  completionHandler: @escaping ([Shows]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        //Convert data to Shows
        let completion: (Data) -> Void = {(data: Data) in
            do {
                //The below is telling the network helper what to do when it gets data
                let shows = try JSONDecoder().decode([Shows].self, from: data)
                completionHandler(shows)
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
