//
//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation


//creating a model to represent how the JSON is structure, so we can decode it
struct ShowInfo: Codable {
    let show: Show
}

//create a custom Type - Show
struct Show: Codable {
    let id: Int
    let name: String //"name": "Girls"
    let rating: Rating?
    let image: Image?
}
struct Rating: Codable {
    let average: Float?
}
struct Image: Codable {
    let medium: String
    let original: String
}

//API Client for getting Shows
struct ShowAPIClient {
    //create a Singleton - only 1 version can exist, no one else can create another
    private init(){} //no one else can initialize
    static let manager = ShowAPIClient() //create one version of ShowAPIClient
    
    //Method to get the Shows
    func getShows(withURL urlStr: String, completionHandler: @escaping ([Show])->Void, errorHandler: @escaping (AppError)->Void) {
    //part# 1 - URL
    guard let url = URL(string: urlStr) else {
        errorHandler(AppError.badURL)
        return
    }
    
    //part# 2 - Completion
    let completion: (Data)->Void =  {(data: Data) in
        //Use Do..try..Catch -- to decode data and catch errors
        do {
            //Decode the data - in this case its Show
            let showInfo = try JSONDecoder().decode([ShowInfo].self,from: data)
//            var shows = [Show]() //creating an empty array called shows of type [Show] from our model
//            //Using the data from showInfo, we will populate the shows variable
//            for show in showInfo {
//                shows.append(show.show)
//            }
             let shows = showInfo.map(){$0.show}

            //After we get the data for the Shows, ow we call the CompletionHandler
            completionHandler(shows)
        }
       
        //part# 3 - CATCH Error - using APPError to make it more descriptive and easier to find
        catch let error {
            errorHandler(AppError.couldNotParseJSON(rawError: error))
        }
    }
        //plug the info in from above into NetworkHelper to get data (array of shows -  show = [Show])
        NetworkHelper.manager.performDataTask(withURL: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
