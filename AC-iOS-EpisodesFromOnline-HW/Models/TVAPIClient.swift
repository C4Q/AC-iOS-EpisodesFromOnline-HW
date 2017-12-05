//
//  TVAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class TVAPIClient {
    private init() {}
    
    static let manager = TVAPIClient()

    func getTVShows(from urlStr: String,
                    completionHandler: @escaping ([TVShows]) -> Void,
                    errorHandler: @escaping (Error) -> Void){
        //make sure you can convert the string into URL
        guard let url = URL(string: urlStr) else {return}
        
        let completion: (Data) -> Void = {(data: Data) in
            do{
                let decoder = JSONDecoder()
                let tvShowsFromTheInternet = try decoder.decode([TVShows].self, from: data)
                var tvShows: [TVShows] = []
                for showInfo in tvShowsFromTheInternet {
                    if let name = showInfo.show.name {//To not load shows with no name
                        if !name.isEmpty {
                            tvShows.append(showInfo)
                        }
                    }
                }
                completionHandler(tvShows)

            } catch {
                errorHandler(error)
            }
        }
        //This is were you call the NetworkHelper based off if the url, completion closure, and error closure made above this line.
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}


