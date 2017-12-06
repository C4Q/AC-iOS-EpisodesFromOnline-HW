//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodeAPIClient {
    private init() {}
    
    static let manager = EpisodeAPIClient()
    
    func getTVEpisodes (from urlStr: String,
                    completionHandler: @escaping ([EpisodeWrapper]) -> Void,
                    errorHandler: @escaping (Error) -> Void){
        //make sure you can convert the string into URL
        guard let url = URL(string: urlStr) else {return}
        
        let completion: (Data) -> Void = {(data: Data) in
            do{
                let decoder = JSONDecoder()
                let tvShowEpisodesFromInternet = try decoder.decode([EpisodeWrapper].self, from: data)
                completionHandler(tvShowEpisodesFromInternet)
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
