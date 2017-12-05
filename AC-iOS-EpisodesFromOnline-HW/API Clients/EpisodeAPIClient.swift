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
                let myDecoder = try JSONDecoder().decode([Episode].self, from: data)
                //turn data into array
                var episodesFromOnline: [Episode] = []
                for episode in myDecoder{
                    episodesFromOnline.append(episode)
                    print("Building array of episodes!")
                }
                //call completionHandler
                completionHandler(episodesFromOnline)
                
            }catch{
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


//func getEpisode(from urlStr: String,
//                completetionHandler: @escaping ([Episode]) -> Void,
//                errorHandler: @escaping (Error) -> Void){
//
//    //make sure you have a url from a string
//    guard let url = URL(string: urlStr) else {return}
//    //set completion
//    let completion: (Data) -> Void = {(data: Data) in
//        //decode
//        do{
//            let myDecoder = try JSONDecoder().decode([Episode].self, from: data)
//            //turn data into an array
//            var episodesFromOnline: [Episode] = []
//            for episode in episodesFromOnline {
//                episodesFromOnline.append(episode)
//            }
//            completetionHandler(myDecoder)
//
//        }catch {
//            errorHandler(error)
//        }
//    }
//
//    //set NetWorkHelper
//    NetworkHelper.manager.performDataTask(with: url,
//                                          completionHandler: completion,
//                                          errorHandler: errorHandler)
//}

