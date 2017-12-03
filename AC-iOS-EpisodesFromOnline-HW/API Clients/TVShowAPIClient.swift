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
                let decoder = try JSONDecoder().decode([TVShow].self, from: data)
                completionHandler(decoder)
                
            }catch{
                errorHandler(error)
            }
        }
        
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion, errorHandler: errorHandler)
    }
}
