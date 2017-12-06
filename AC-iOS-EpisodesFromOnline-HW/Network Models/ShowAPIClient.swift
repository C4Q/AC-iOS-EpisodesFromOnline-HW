//
//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
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
//                var tvShows: [TVShows] = []
//                for showInfo in tvShowsFromTheInternet {
//                    if let name = showInfo.show.name { // To not load shows with no name.
//                        if !name.isEmpty {
//                            tvShows.append(showInfo)
//                        }
//                    }
//                }
//                dump(tvShows)
                completionHandler(tvShowsFromTheInternet)
                
            } catch {
                errorHandler(error)
            }
        }
        
        //This is where you call the Network Helper based off of the URL, completion closure, and the error closure (see above).
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
