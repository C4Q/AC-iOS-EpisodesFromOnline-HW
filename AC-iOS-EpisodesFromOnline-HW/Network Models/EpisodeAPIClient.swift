//
//  EpisodeAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Ashlee Krammer on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct EpisodeAPIClient{
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from urlStr: String, completionHandler: @escaping ([Episode]) -> Void, errorHandler: @escaping (AppError) -> Void){
        
        
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let episodeArr = try myDecoder.decode([Episode].self, from: data)
                
                completionHandler(episodeArr)
                
            } catch{
                print("Episode List Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
