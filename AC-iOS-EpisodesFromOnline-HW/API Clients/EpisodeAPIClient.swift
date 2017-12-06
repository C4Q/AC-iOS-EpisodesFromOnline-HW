//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class EpisodeAPIClient {
    private init(){}
    static let manager = EpisodeAPIClient()
    
    func getEpisode(from urlStr: String,
                    completionHandler: @escaping ([Episode]) -> Void,
                    errorHandler: @escaping (Error) -> Void){
        //make sure you can get a url from a string
        guard let url = URL(string: urlStr) else {return}
        //set completion with do/catch & decoder
        let completion: (Data) -> Void = {(data: Data) in
            do{
                //JSON -> Episode Data
                let myDecoder = try JSONDecoder().decode([Episode].self, from: data)
                
                //Data -> [Episode]
                var episodesFromOnline: [Episode] = []
                for episode in myDecoder{
                    episodesFromOnline.append(episode)
                    print("Building array of episodes!")
                }
                //call completionHandler
                completionHandler(episodesFromOnline)
                
            }catch{
                //App HAndling: "bad data"
                errorHandler(error)
                print("Unable to retrieve data")
            }
        }
        //call NetworkHelper
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
