//
//  TVShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class TVShowAPICLient {
    private init(){}
    static let manager = TVShowAPICLient()
    
    func getTVShow(from urlStr: String,
                   completionHandler: @escaping ([TVShow]) -> Void,
                   errorHandler: @escaping (Error) -> Void){
        //make sure you can get url from the string
        guard let url = URL(string: urlStr) else {return}
        
        let completion: (Data) -> Void = {(data: Data) in
            do{
                let tvShowsFromOnline = try JSONDecoder().decode([TVShow].self, from: data)//turning json into tvshow data
                var tvShowArray: [TVShow] = []
                
                for tvShow in tvShowsFromOnline { //turn the data into an array of [TVShow]
                    tvShowArray.append(tvShow)
                    print("Building array of tvshows!")
                }
                completionHandler(tvShowsFromOnline)
                
            } catch {
                errorHandler(error)
                print("Unable to retrieve data")
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
