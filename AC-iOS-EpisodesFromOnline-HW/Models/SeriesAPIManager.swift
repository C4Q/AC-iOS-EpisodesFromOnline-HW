//
//  SeriesAPIManager.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

//class SeriesAPIClient {
//    private init() {}
//    
//    static let manager = SeriesAPIClient()
//    
//    func getTVShows(from urlStr: String,
//                    completionHandler: @escaping ([Series]) -> Void,
//                    errorHandler: @escaping (Error) -> Void){
//        //make sure you can convert the string into URL
//        guard let url = URL(string: urlStr) else {return}
//        
//        let completion: (Data) -> Void = {(data: Data) in
//            do{
//                let decoder = JSONDecoder()
//                let allShowsFromASeries = try decoder.decode([Series].self, from: data)
//                var allEpisodes: [Series] = []
//                for episodeInfo in allShowsFromASeries {
//                    allEpisodes.append(episodeInfo)
//                }
//                completionHandler(allEpisodes)
//                
//            } catch {
//                errorHandler(error)
//            }
//        }
//        
//        NetworkHelper.manager.performDataTask(with: url,
//                                              completionHandler: completion,
//                                              errorHandler: errorHandler)
//    }
//}

