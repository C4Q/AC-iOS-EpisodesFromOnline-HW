//
//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Episode: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: Image?
    let summary: String
}



//Create EpisodeAPIClient for Episode
struct EpisodesAPIClient {
    
    //create a Singleton - only 1 version can exist, no one else can create another
    private init(){}
    static let manager = EpisodesAPIClient()
    
    //create a method to get the episodes
    func getEpisodes(withURL urlStr: String, completionHandler: @escaping ([Episode])->Void, errorHandler: @escaping (AppError)->Void) {
        
    //part# 1 - get the URL
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL)
            return
        }

        //part# 2 - Completion
        let completion: (Data)->Void =  {(data: Data) in
            //Use Do..try..Catch -- to decode data and catch errors
            do {
                //Decode the data - in this case its Show
                let episodes = try JSONDecoder().decode([Episode].self,from: data)

                //After we get the data for the Shows, ow we call the CompletionHandler
                completionHandler(episodes)
            }
    //part# 3 - CATCH Error - using APPError to make it more descriptive and easier to find
    //use NetworkHelper with the data above - to get data (array of shows -  show = [Show])
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        //plug the info in from above into NetworkHelper to get data (array of shows -  show = [Show])
        NetworkHelper.manager.performDataTask(withURL: url, completionHandler: completion, errorHandler: errorHandler)
    }
}

