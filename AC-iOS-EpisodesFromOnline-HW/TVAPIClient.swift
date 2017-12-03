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
                completionHandler(tvShowsFromTheInternet)
            } catch {
                errorHandler(error)
            }
        }
        
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}


