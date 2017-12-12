//
//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Ashlee Krammer on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ShowAPIClient{
    private init() {}
    static let manager = ShowAPIClient()
    func getShows(from urlStr: String, completionHandler: @escaping ([Show]) -> Void, errorHandler: @escaping (AppError) -> Void){
        
        
        guard let url = URL(string: urlStr) else{
            errorHandler(.badURL)
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let showsArr = try myDecoder.decode([Show].self, from: data)
                completionHandler(showsArr)
                
            } catch{
                print("Show Search Has This Error: " + error.localizedDescription)
                errorHandler(.couldNotParseJSON)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
