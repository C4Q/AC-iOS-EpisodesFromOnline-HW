//
//  ShowAPIHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct  ShowAPIHelper {
    private init() {}
    
    static var shared = ShowAPIHelper()
    
//    var defaultStr = "https://api.tvmaze.com/search/shows?q="
    
    var urlStr = "http://api.tvmaze.com/shows"
    
//    func getUrl(str:String) -> String {
//        return "https://api.tvmaze.com/search/shows?q=\(str)"
//    }
    
    
    mutating func getShows(completionHandler: @ escaping (Result<[Show], AppError>) -> ()) {
//        
//        if str != nil {
//            urlStr = getUrl(str: str!)
//        } else {
//            urlStr = defaultStr
//        }
        
        NetworkManager.shared.fetchData(urlString: urlStr) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let showInfo = try JSONDecoder().decode([Show].self, from: data)
                    completionHandler(.success(showInfo))
                    
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}

